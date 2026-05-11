-- ######### INSTALLATION #########
vim.pack.add({
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
})

-- ######### CONFIG #########
require("lualine").setup({
	options = {
		theme = require("lualine.themes.earthshine"),
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff" },
		lualine_c = { "diagnostics" },
		lualine_x = { "filetype", "lsp_status" },
		lualine_y = { "windows" },
		lualine_z = {
			{
				--- macro recording on statusline
				require("noice").api.statusline.mode.get,
				cond = require("noice").api.statusline.mode.has,
				color = { fg = "#ffffff", bg = "#550000" },
			},
		},
	},
})
