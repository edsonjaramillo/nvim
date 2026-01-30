local snack_helpers = require("helpers.snacks-helpers")
local snacks = require("snacks")
local wk = require("which-key")

wk.add({
	mode = "n",
	{
		"<leader>s",
		group = "Search",
	},

	{
		"<leader>sx",
		"<cmd>nohlsearch<CR>",
		desc = "Clear search highlight",
	},
})
