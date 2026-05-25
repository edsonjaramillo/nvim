-- ######### INSTALLATION #########
local abide_path = "/Users/edson/code/plugins/abide"

if vim.fn.isdirectory(abide_path) == 1 then
	vim.opt.runtimepath:prepend(abide_path)
else
	vim.pack.add({
		{ src = "https://github.com/edsonjaramillo/abide" },
	})
end

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
