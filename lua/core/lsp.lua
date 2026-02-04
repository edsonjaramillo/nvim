vim.lsp.config("tailwindcss", {
	settings = {
		tailwindCSS = {
			classFunctions = { "cva", "cx", "cn" },
		},
	},
})

local plugin_paths = vim.fn.globpath(vim.fn.expand("~/code/plugins/"), "*/lua", false, true)
local library = {
	vim.env.VIMRUNTIME,
	"${VIMRUNTIME}/lua",
	"${VIMRUNTIME}/lua/vim",
	plugin_paths,
}

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- library = vim.api.nvim_get_runtime_file("", true),
				library = library,
				checkThirdParty = false,
			},
		},
	},
})

vim.lsp.enable({
	"bashls",
	"copilot",
	"emmet_language_server",
	"eslint",
	"golangci_lint_ls",
	"gopls",
	"jsonls",
	"lua_ls",
	"marksman",
	"nil_ls",
	"tailwindcss",
	"tsgo",
	"ty",
	"yamlls",
})

vim.diagnostic.config({
	virtual_text = true,
	underline = false,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	},
})
