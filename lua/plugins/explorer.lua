-- ######### INSTALLATION #########
vim.pack.add({
	{ src = "https://github.com/stevearc/oil.nvim" },
})

-- ######### CONFIG #########
local oil = require("oil")
oil.setup({ view_options = { show_hidden = true } })

-- ######### KEYMAPS #########
local wk = require("which-key")

wk.add({
	mode = "n",
	{
		"<leader>e",
		group = "Explorer",
	},
	{
		"<leader>ee",
		function()
			oil.open()
		end,
		desc = "Open Oil Explorer",
	},
	{
		"-",
		function()
			oil.open()
		end,
		desc = "Open Parent Directory",
	},
})
