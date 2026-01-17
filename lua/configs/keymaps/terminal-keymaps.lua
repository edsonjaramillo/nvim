local tt = require("toggleterm")
local wk = require("which-key")

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
