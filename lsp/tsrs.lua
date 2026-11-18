---@brief
--- tsrs (https://github.com/oxc-project/tsrs): Rust port of the TypeScript 7 compiler + language server.
---
--- Attaches only to projects that have tsrs installed locally (node_modules/.bin/tsrs,
--- searched upward from the file so monorepos with a hoisted tsrs work). No global fallback.
--- Root detection (nearest lockfile, then .git) follows nvim-lspconfig's lsp/tsc.lua.

local bin_cache = {} ---@type table<string, string>
local notified = {} ---@type table<string, boolean>

--- Nearest project-local tsrs binary, walking up from the buffer's file.
---@param bufnr integer
---@return string?
local function find_local_tsrs(bufnr)
	local file = vim.api.nvim_buf_get_name(bufnr)
	if file == "" then
		return nil
	end
	for dir in vim.fs.parents(file) do
		local bin = vim.fs.joinpath(dir, "node_modules/.bin/tsrs")
		if vim.fn.executable(bin) == 1 then
			return bin
		end
	end
end

---@type vim.lsp.Config
return {
	cmd = function(dispatchers, config)
		local bin = bin_cache[(config or {}).root_dir]
		return vim.lsp.rpc.start({ bin, "--lsp", "--stdio" }, dispatchers)
	end,
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
	},
	root_dir = function(bufnr, on_dir)
		local root = vim.fs.root(bufnr, {
			{ "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" },
			".git",
		}) or vim.fn.getcwd()

		local bin = find_local_tsrs(bufnr)
		if not bin then
			-- Not migrated yet: no TS server here. Tell once per project.
			if not notified[root] then
				notified[root] = true
				vim.notify(
					("tsrs: not installed in %s (add it with e.g. `bun add -d tsrs`)"):format(root),
					vim.log.levels.INFO
				)
			end
			return
		end

		bin_cache[root] = bin
		on_dir(root)
	end,
	settings = {
		["js/ts"] = {
			inlayHints = {
				parameterNames = {
					enabled = "literals",
					suppressWhenArgumentMatchesName = true,
				},
				parameterTypes = { enabled = true },
				variableTypes = { enabled = true },
				propertyDeclarationTypes = { enabled = true },
				functionLikeReturnTypes = { enabled = true },
				enumMemberValues = { enabled = true },
			},
			referencesCodeLens = {
				enabled = true,
				showOnAllFunctions = true,
			},
			implementationsCodeLens = {
				enabled = true,
				showOnInterfaceMethods = true,
				showOnAllClassMethods = true,
			},
		},
	},
}
