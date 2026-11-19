-- ######### INSTALLATION #########
vim.pack.add({
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
})

-- ######### CONFIG #########
require("lualine").setup({
	options = {
		theme = "earthshine",
		globalstatus = true, -- matches `laststatus = 3` in options.lua
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff" },
		lualine_c = {
			{ "filename", path = 1 }, -- relative path
			"diagnostics",
		},
		lualine_x = { "lsp_status", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})
