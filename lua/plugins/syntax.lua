local languages = require("utils.parsers")

---@module 'lazy'
---@type LazySpec[]
return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		opts = {},
		config = function()
			require("nvim-treesitter").install(languages.tree_sitter)
		end,
	},
	{
		"artemave/workspace-diagnostics.nvim",
	},
}
