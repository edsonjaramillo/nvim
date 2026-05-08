-- ######### INSTALLATION #########
vim.pack.add({
	{ src = "https://github.com/akinsho/toggleterm.nvim" },
})

-- ######### CONFIG #########
local toggleterm = require("toggleterm")
toggleterm.setup({
	hide_numbers = true,
})

local terminal = require("toggleterm.terminal").Terminal

local basic_terminal = terminal:new({
	hidden = true,
	direction = "float",
})

local lazygit = terminal:new({
	cmd = "lazygit",
	hidden = true,
	direction = "float",
})

local yazi = terminal:new({
	cmd = "yazi",
	hidden = true,
	direction = "float",
})

local codex = terminal:new({
	cmd = "codex",
	hidden = true,
	direction = "float",
})

-- ######### KEYMAPS #########
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
			basic_terminal:toggle()
		end,
		desc = "Toggle Terminal",
	},
	{
		"<leader>tg",
		function()
			lazygit:toggle()
		end,
		desc = "Toggle Lazygit",
	},
	{
		"<leader>ty",
		function()
			yazi:toggle()
		end,
		desc = "Toggle Yazi",
	},
	{
		"<leader>tc",
		function()
			codex:toggle()
		end,
		desc = "Toggle Codex",
	},
})
