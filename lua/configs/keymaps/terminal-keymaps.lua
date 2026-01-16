local wk = require("which-key")
local tt = require("toggleterm")

wk.add({
	mode = "n",
	{
		"<leader>t",
		group = "Terminal",
	},
	{
		"<leader>tt",
		function()
			tt.toggle()
		end,
		desc = "Toggle Terminal",
	},
})
