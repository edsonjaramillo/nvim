-- ######### INSTALLATION #########
vim.pack.add({
	{ src = "https://github.com/ibhagwan/fzf-lua" },
})

-- ######### CONFIG #########
local fzf_lua = require("fzf-lua")
local file_edit_action = require("fzf-lua.actions").file_edit
fzf_lua.setup({
	files = {
		actions = {
			["default"] = file_edit_action,
		},
	},
	ui_select = true,
})

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
			fzf_lua.files()
		end,
		desc = "Find Files",
	},
	{
		"<leader>fc",
		function()
			fzf_lua.files({ cwd = vim.fn.stdpath("config") })
		end,
		desc = "Find nvim config files",
	},
	{
		"<leader>f.",
		function()
			fzf_lua.files({ cwd = "~/dotfiles/", hidden = true })
		end,
		desc = "Find dotfiles",
	},
	{
		"<leader>fb",
		function()
			fzf_lua.buffers()
		end,
		desc = "Find Buffers",
	},
	{
		"<leader>fg",
		function()
			fzf_lua.live_grep({
				actions = {
					["default"] = require("fzf-lua.actions").file_edit,
				},
			})
		end,
		desc = "Find grep",
	},
	{
		"<leader>fG",
		function()
			fzf_lua.grep_curbuf()
		end,
		desc = "Find grep current buffer",
	},
	{
		"<leader>fr",
		function()
			fzf_lua.oldfiles({
				cwd_only = true,
			})
		end,
		desc = "Find recent files",
	},
	{
		"<leader>fs",
		function()
			fzf_lua.git_status()
		end,
		desc = "Find git status",
	},
	-- IMPROVEMENT: extra pickers that are handy for config work and recovery.
	{
		"<leader>fh",
		function()
			fzf_lua.helptags()
		end,
		desc = "Find help tags",
	},
	{
		"<leader>fk",
		function()
			fzf_lua.keymaps()
		end,
		desc = "Find keymaps",
	},
	{
		"<leader>fw",
		function()
			fzf_lua.grep_cword()
		end,
		desc = "Find word under cursor",
	},
	{
		"<leader>fR",
		function()
			fzf_lua.resume()
		end,
		desc = "Resume last picker",
	},
})
