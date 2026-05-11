-- ######### INSTALLATION #########
vim.pack.add({
	{ src = "https://github.com/ibhagwan/fzf-lua" },
})

-- ######### CONFIG #########
local fzf_lua = require("fzf-lua")
fzf_lua.setup({
	files = {
		actions = {
			["default"] = require("fzf-lua.actions").file_edit,
		},
	},
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
		"<leader>fb",
		function()
			fzf_lua.buffers()
		end,
		desc = "Find Buffers",
	},
	{
		"<leader>fg",
		function()
			fzf_lua.live_grep()
		end,
		desc = "Find grep",
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
})
