-- ######### INSTALLATION #########
vim.pack.add({
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
})

-- ######### CONFIG #########
require("gitsigns").setup()

-- ######### KEYMAPS #########
local wk = require("which-key")

wk.add({
	mode = "n",
	{
		"<leader>g",
		group = "Git",
	},
	{
		"<leader>gd",
		":Gitsigns diffthis<CR>",
		desc = "Git Diff This",
	},
	{
		"<leader>ghp",
		":Gitsigns preview_hunk<CR>",
		desc = "Git Hunk Preview",
	},
	{
		"<leader>ghr",
		":Gitsigns reset_hunk<CR>",
		desc = "Git Reset Hunk",
	},
	{
		"<leader>ghs",
		":Gitsigns stage_hunk<CR>",
		desc = "Git Stage Hunk",
	},
	{
		"<leader>ghu",
		":Gitsigns undo_stage_hunk<CR>",
		desc = "Git Undo Stage Hunk",
	},
})
