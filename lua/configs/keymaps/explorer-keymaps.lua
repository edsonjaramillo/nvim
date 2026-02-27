local files_helper = require("helpers.files-helpers")
local wk = require("which-key")

wk.add({
	mode = "n",
	{
		"<leader>e",
		"<cmd>Yazi<cr>",
		desc = "Open Explorer (Oil)",
	},
})
