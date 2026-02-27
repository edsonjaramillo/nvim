---@module 'lazy'
---@type LazySpec[]
return {
	{
		-- "edsonjaramillo/abide",
		-- switch source to get repo instead of local dev
		dir = "~/code/plugins/abide",
		---@module 'abide'
		---@type AbideOptions
		opts = {
			formatters = {
				alejandra = { enabled = true },
				gofumpt = { enabled = true },
				prettier = {
					enabled = true,
					fallback_args = { "--use-tabs" },
				},
				shfmt = { enabled = true },
				stylua = { enabled = true },
				taplo = { enabled = true },
				yamlfmt = { enabled = false },
			},
		},
		config = function(_, opts)
			require("abide").setup(opts)
		end,
	},
}
