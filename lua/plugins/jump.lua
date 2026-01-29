---@module 'lazy'
---@type LazySpec[]
return {
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@module 'flash'
		---@type Flash.Config
		opts = {
			modes = {
				search = {
					enabled = true,
				},
			},
			search = {
				mode = "search",
			},
		},
	},
}
