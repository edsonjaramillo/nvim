-- ######### INSTALLATION #########
vim.opt.runtimepath:prepend("~/code/plugins/quickfile")

-- ######### KEYMAPS #########
local quickfile = require("quickfile")
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
			quickfile.create()
		end,
		desc = "Create File",
	},
	{
		"<leader>er",
		function()
			quickfile.rename()
		end,
		desc = "Rename File",
	},
	{
		"<leader>ed",
		function()
			quickfile.delete()
		end,
		desc = "Delete File",
	},
	{
		"<leader>em",
		function()
			quickfile.move()
		end,
		desc = "Move File",
	},
})
