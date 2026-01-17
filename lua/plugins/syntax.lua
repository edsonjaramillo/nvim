---@module 'lazy'
---@type LazySpec[]
return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		branch = "main",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"vim",
				"vimdoc",
				"nix",
				"lua",
				-- shell
				"bash",
				-- web
				"css",
				"html",
				"javascript",
				"typescript",
				"tsx",
				-- programming
				"python",
				"go",
				-- config
				"json",
				"jsonc",
				"markdown",
				"toml",
				"yaml",
			},
		},
		config = function(_, opts)
			require("nvim-treesitter").install(opts.ensure_installed)
		end,
	},
	{
		"artemave/workspace-diagnostics.nvim",
	},
}
