local languages = require("utils.languages")

---@module 'lazy'
---@type LazySpec[]
return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").install(languages.tree_sitter)
		end,
	},
	{
		"artemave/workspace-diagnostics.nvim",
	},
}
