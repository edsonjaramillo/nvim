-- ######### INSTALLATION #########
vim.pack.add({
	{ src = "https://github.com/akinsho/bufferline.nvim" },
})

-- ######### CONFIG #########
require("bufferline").setup({
	options = {
		mode = "buffers",
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(count, level, _, _)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end,
		numbers = "buffer_id",
	},
})

-- ######### KEYMAPS #########
local wk = require("which-key")

wk.add({
	mode = "x",
	{
		"<leader>v",
		group = "Visual",
	},
	{
		"<leader>va",
		"ggVG",
		desc = "Select All",
	},
})

wk.add({
	mode = "n",
	{
		"<leader>v",
		group = "Visual",
	},
	{
		"<leader>va",
		"ggVG",
		desc = "Select All",
	},
	{
		"<leader>vl",
		"$V",
		desc = "Select Line",
	},
})

wk.add({
	mode = "x",
	{ "<A-k>", ":m '<-2<CR>gv=gv", desc = "Move Line Up" },
	{ "<A-j>", ":m '>+1<CR>gv=gv", desc = "Move Line Down" },
})

wk.add({
	mode = "x",
	{
		"<leader>s",
		group = "Sort",
	},
	{ "<leader>sa", ":'<,'>sort<CR>", desc = "Sort Ascending" },
	{ "<leader>sd", ":'<,'>sort!<CR>", desc = "Sort Descending" },
	{ "<leader>su", ":'<,'>sort u<CR>", desc = "Sort Unique" },
	{ "<leader>sn", ":'<,'>sort n<CR>", desc = "Sort Numerically" },
	{ "<leader>sr", ":'<,'>sort r<CR>", desc = "Sort Reverse" },
	{ "<leader>si", ":'<,'>sort i<CR>", desc = "Sort Ignore Case" },
})
