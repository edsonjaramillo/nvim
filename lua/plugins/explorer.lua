-- ######### INSTALLATION #########
vim.pack.add({
	{ src = "/Users/edson/code/plugins/filemaker" },
})

-- ######### CONFIG #########

local filemaker = require("filemaker")
filemaker.setup({
	picker = "fzf_lua",
	show_hidden = true,
})

-- ######### KEYMAPS #########
local wk = require("which-key")

wk.add({
	mode = "n",
	{
		"<leader>e",
		group = "Explorer",
	},
	{
		"<leader>ec",
		function()
			filemaker.create()
		end,
		desc = "Create File",
	},
})
