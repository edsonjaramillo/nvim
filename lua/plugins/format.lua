-- ######### INSTALLATION #########
vim.pack.add({
	{ src = "https://github.com/edsonjaramillo/abide" },
})

-- ######### CONFIG #########
require("abide").setup({
	formatters = {
		alejandra = { enabled = true },
		gofumpt = { enabled = true },
		oxfmt = { enabled = true },
		ruff = { enabled = true, config_files = { "ruff.toml" } },
		shfmt = { enabled = true },
		stylua = { enabled = true },
		taplo = { enabled = true },
		yamlfmt = { enabled = false },
	},
})
