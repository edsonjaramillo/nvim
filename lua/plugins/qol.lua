---@module 'lazy'
---@type LazySpec[]
return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		"numToStr/Comment.nvim",
		opts = {},
		lazy = false,
	},
	{
		"nvim-focus/focus.nvim",
		version = "*",
		config = function()
			require("focus").setup({
				autoresize = {
					enable = false,
				},
				split = {
					bufnew = true,
				},
				ui = {
					relativenumber = true,
					winhighlight = false,
				},
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		config = function(_, opts)
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true,
					enable_rename = true,
					enable_close_on_slash = false,
				},
			})
		end,
	},
	{
		"mg979/vim-visual-multi",
		lazy = false,
	},
	{
		"yutkat/confirm-quit.nvim",
		event = "CmdlineEnter",
		opts = {},
	},
}
