local flash = require("flash")
local wk = require("which-key")

wk.add({
	mode = { "n", "x", "o" },
	{
		"<leader>j",
		function()
			flash.jump()
		end,
		desc = "Flash Jump",
	},
})

wk.add({
	mode = { "x", "o" },
	{
		"r",
		function()
			flash.treesitter_search()
		end,
		desc = "Treesitter Search",
	},
	{
		"s",
		function()
			flash.treesitter()
		end,
		desc = "Treesitter",
	},
})
