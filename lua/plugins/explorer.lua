-- ######### INSTALLATION #########
vim.pack.add({
	{ src = "https://github.com/stevearc/oil.nvim" },
})

-- ######### CONFIG #########
local oil = require("oil")
oil.setup()
oil.toggle_hidden()

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
})
