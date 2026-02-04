vim.lsp.config("tailwindcss", {
	settings = {
		tailwindCSS = {
			classFunctions = { "cva", "cx", "cn" },
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
