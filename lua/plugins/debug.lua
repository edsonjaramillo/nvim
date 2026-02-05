---@module 'lazy'
---@type LazySpec[]
return {
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			require("dapui").setup()
		end,
	},
	{
		"jbyuki/one-small-step-for-vimkind",
	},
	{
		"leoluz/nvim-dap-go",
		config = function()
			require("dap-go").setup()
		end,
	},
}
