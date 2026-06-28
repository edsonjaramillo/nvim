-- ######### INSTALLATION #########
vim.pack.add({
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
})

-- ######### CONFIG #########
vim.lsp.config("tailwindcss", {
	settings = {
		tailwindCSS = {
			classFunctions = { "cva", "cx", "cn" },
		},
	},
})

vim.lsp.config("oxlint", {
	settings = {
		typeAware = true,
		disableNestedConfig = true,
	},
})

-- Added to override tsgo settings to use
-- tsc command instead now that rc is available
local tsrc = require("experimental.ts-rc")
vim.lsp.config("tsgo", tsrc.lsp_settings)

local plugin_paths = vim.fn.globpath(vim.fn.expand("~/code/plugins/"), "*/lua", false, true)
local library = vim.list_extend({
	vim.env.VIMRUNTIME,
	"${VIMRUNTIME}/lua",
	"${VIMRUNTIME}/lua/vim",
}, plugin_paths)

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
				library = library,
				checkThirdParty = false,
			},
		},
	},
})

vim.lsp.enable({
	"basedpyright",
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
	"oxlint",
	"tailwindcss",
	"taplo",
	"tsgo",
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

-- ######### KEYMAPS #########
local fzf = require("fzf-lua")
local wk = require("which-key")

wk.add({
	mode = "n",
	{
		"<leader>l",
		group = "LSP",
	},
	{
		"<leader>lR",
		"<cmd>LspRestart<cr>",
		desc = "Restart LSP",
	},
	{
		"<leader>ld",
		function()
			fzf.lsp_document_diagnostics()
		end,
		desc = "Diagnostics",
	},
	{
		"<leader>lD",
		function()
			fzf.lsp_workspace_diagnostics()
		end,
		desc = "Diagnostics (Workspace)",
	},
	{
		"<leader>lr",
		vim.lsp.buf.rename,
		desc = "Rename",
	},
	{
		"<leader>lc",
		function()
			require("fzf-lua").lsp_code_actions()
		end,
		desc = "Code Actions",
	},
	{
		"K",
		vim.lsp.buf.hover({
			focusable = false,
		}),
		desc = "Hover",
	},
})
