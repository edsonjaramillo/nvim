-- ######### CONFIG #########
local snacks = require("snacks")

-- ######### KEYMAPS #########
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
			snacks.picker.files()
		end,
		desc = "Find Files",
	},
	{
		"<leader>fc",
		function()
			snacks.picker.files({ cwd = vim.fn.stdpath("config") })
		end,
		desc = "Find nvim config files",
	},
	{
		"<leader>f.",
		function()
			snacks.picker.files({ cwd = vim.fn.expand("~/dotfiles/") })
		end,
		desc = "Find dotfiles",
	},
	{
		"<leader>fb",
		function()
			snacks.picker.buffers()
		end,
		desc = "Find Buffers",
	},
	{
		"<leader>fg",
		function()
			snacks.picker.grep()
		end,
		desc = "Find grep",
	},
	{
		"<leader>fG",
		function()
			snacks.picker.lines()
		end,
		desc = "Find grep current buffer",
	},
	{
		"<leader>fr",
		function()
			snacks.picker.recent({ filter = { cwd = true } })
		end,
		desc = "Find recent files",
	},
	{
		"<leader>fs",
		function()
			snacks.picker.git_status()
		end,
		desc = "Find git status",
	},
	{
		"<leader>fh",
		function()
			snacks.picker.help()
		end,
		desc = "Find help tags",
	},
	{
		"<leader>fk",
		function()
			snacks.picker.keymaps()
		end,
		desc = "Find keymaps",
	},
	{
		"<leader>fw",
		function()
			snacks.picker.grep_word()
		end,
		desc = "Find word under cursor",
	},
	{
		"<leader>fR",
		function()
			snacks.picker.resume()
		end,
		desc = "Resume last picker",
	},
})
