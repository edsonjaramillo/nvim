-- ######### INSTALLATION #########
vim.pack.add({
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
})

-- ######### CONFIG #########
require("gitsigns").setup()

-- ######### KEYMAPS #########
local gitsigns = require("gitsigns")
local wk = require("which-key")

wk.add({
	mode = "n",
	{
		"<leader>g",
		group = "Git",
	},
	{
		"<leader>gh",
		group = "Hunk",
	},
	{
		"<leader>gd",
		function()
			gitsigns.diffthis()
		end,
		desc = "Git Diff This",
	},
	{
		"<leader>ghp",
		function()
			gitsigns.preview_hunk()
		end,
		desc = "Git Hunk Preview",
	},
	{
		"<leader>ghr",
		function()
			gitsigns.reset_hunk()
		end,
		desc = "Git Reset Hunk",
	},
	{
		"<leader>ghs",
		function()
			gitsigns.stage_hunk()
		end,
		desc = "Git Stage/Unstage Hunk",
	},
	{
		"<leader>ghS",
		function()
			gitsigns.stage_buffer()
		end,
		desc = "Git Stage Buffer",
	},
	{
		"<leader>ghR",
		function()
			gitsigns.reset_buffer()
		end,
		desc = "Git Reset Buffer",
	},
	{
		"<leader>gb",
		function()
			gitsigns.blame_line({ full = true })
		end,
		desc = "Git Blame Line",
	},
	{
		"<leader>gB",
		function()
			gitsigns.toggle_current_line_blame()
		end,
		desc = "Git Toggle Inline Blame",
	},
	{
		"]h",
		function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gitsigns.nav_hunk("next")
			end
		end,
		desc = "Next Git Hunk",
	},
	{
		"[h",
		function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gitsigns.nav_hunk("prev")
			end
		end,
		desc = "Previous Git Hunk",
	},
})

wk.add({
	mode = "x",
	{
		"<leader>gh",
		group = "Hunk",
	},
	{
		"<leader>ghs",
		function()
			gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end,
		desc = "Git Stage Selected Lines",
	},
	{
		"<leader>ghr",
		function()
			gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end,
		desc = "Git Reset Selected Lines",
	},
})

wk.add({
	mode = { "o", "x" },
	{
		"ih",
		function()
			gitsigns.select_hunk()
		end,
		desc = "Git Hunk",
	},
})
