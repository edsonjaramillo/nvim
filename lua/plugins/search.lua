-- ######### INSTALLATION #########
vim.pack.add({
	{ src = "https://github.com/MagicDuck/grug-far.nvim" },
})

-- ######### CONFIG #########
local grug_far = require("grug-far")
grug_far.setup()

-- ######### KEYMAPS #########
local wk = require("which-key")
wk.add({
	mode = "n",
	{
		"<leader>s",
		group = "Search and Replace",
	},
	{
		"<leader>so",
		function()
			grug_far.open()
		end,
		desc = "Open Search and Replace",
	},
})

wk.add({
	mode = "x",
	{
		"<leader>so",
		function()
			grug_far.with_visual_selection({
				prefills = {
					paths = vim.fn.expand("%"),
				},
			})
		end,
		desc = "Replace Selection in File",
	},
})
