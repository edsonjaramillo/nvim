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

local function reopen_current_file()
	local buf = vim.api.nvim_get_current_buf()
	local file = vim.api.nvim_buf_get_name(buf)

	if file == "" then
		vim.notify("Current buffer is not backed by a file", vim.log.levels.WARN)
		return
	end

	if vim.bo[buf].modified then
		vim.notify("Save or discard changes before reopening this file", vim.log.levels.WARN)
		return
	end

	local view = vim.fn.winsaveview()
	vim.cmd("bdelete " .. buf)
	vim.cmd.edit(vim.fn.fnameescape(file))
	pcall(vim.fn.winrestview, view)
end

wk.add({
	mode = { "n" },
	{
		"<leader>b",
		group = "Buffer",
	},
	{
		"<leader>bd",
		"<cmd>bdelete<CR>",
		desc = "Close",
	},
	{
		"<leader>bD",
		"<cmd>BufferLineCloseOthers<CR>",
		desc = "Close Others",
	},
	{
		"<leader>br",
		reopen_current_file,
		desc = "Reopen Current File",
	},
})
