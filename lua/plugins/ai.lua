-- ######### INSTALLATION #########
vim.pack.add({
	{ src = "https://github.com/edsonjaramillo/rowdy" },
})

-- ######### CONFIG #########

-- ######### KEYMAPS #########
local wk = require("which-key")

wk.add({
	mode = "n",
	{
		"<leader>a",
		group = "AI",
	},
	{
		"<leader>ac",
		function()
			require("utils.conventional-commits").commit()
		end,
		desc = "Git Commit Message",
	},
})
