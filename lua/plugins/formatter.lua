---@module 'lazy'
---@type LazySpec[]
return {
	{
		-- "edsonjaramillo/abide",
		-- switch source to get repo instead of local dev
		dir = "~/code/nvim-plugins/abide",
		---@module 'abide'
		---@type FormOptions
		opts = {
			debug = true,
			formatters = {
				"alejandra",
				"gofumpt",
				"prettier",
				"shfmt",
				"stylua",
				"taplo",
				"yamlfmt",
			},
		},
		config = function(_, opts)
			require("abide").setup(opts)
		end,
	},
}
