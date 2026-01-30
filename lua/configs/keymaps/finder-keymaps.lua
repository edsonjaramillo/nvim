local files_helper = require("helpers.files-helpers")
local snacks = require("snacks")
local snacks_helper = require("helpers.snacks-helpers")
local wk = require("which-key")

wk.add({
	mode = "n",
	{
		"<leader>f",
		group = "Finder",
	},
	{
		"<leader>ff",
		function()
			snacks.picker.files({
				hidden = files_helper.is_dotfiles(),
				exclude = snacks_helper.folder_exclude,
			})
		end,
		desc = "Find Files (Snacks)",
	},
	{
		"<leader>fr",
		function()
			snacks.picker.recent({
				filter = { paths = snacks_helper.priotize_cwd },
				matcher = { cwd_bonus = true },
			})
		end,
		desc = "Recent Files (Snacks)",
	},
	{
		"<leader>fc",
		function()
			snacks.picker.files({ cwd = vim.fn.stdpath("config"), hidden = true })
		end,
		desc = "Config Files (Snacks)",
	},
	{
		"<leader>fp",
		function()
			snacks.picker.files({ cwd = "~/code/plugins/" })
		end,
		desc = "Plugin Files (Snacks)",
	},
	{
		"<leader>fm",
		function()
			snacks.picker.man()
		end,
		desc = "Man Pages (Snacks)",
	},
	{
		"<leader>fH",
		function()
			snacks.picker.highlights()
		end,
		desc = "Highlights",
	},
	{
		"<leader>fls",
		function()
			snacks.picker.lsp_symbols()
		end,
		desc = "Go to Definition (Snacks)",
	},
	{
		"<leader>fL",
		function()
			snacks.picker.treesitter()
		end,
	},
	{
		"<leader>fg",
		function()
			snacks.picker.grep({ hidden = true, exclude = snack_helpers.folder_exclude })
		end,
		desc = "Grep (Snacks)",
	},
	{
		"<leader>fk",
		function()
			snacks.picker.keymaps()
		end,
		desc = "Keymaps (Snacks)",
	},
	{
		"<leader>fC",
		function()
			snacks.picker.commands()
		end,
		desc = "Commands (Snacks)",
	},
})
