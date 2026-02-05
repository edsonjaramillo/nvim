local wk = require("which-key")

wk.add({
	mode = "n",
	{ "<leader>d", group = "Debug" },
	{
		"<leader>dt",
		function()
			require("dapui").toggle()
		end,
		desc = "Toggle Debugger UI",
	},
	{
		"<leader>dc",
		function()
			require("dap").continue()
		end,
		desc = "Start/Continue Debugging",
	},
	{
		"<leader>dd",
		function()
			require("dap").toggle_breakpoint()
		end,
		desc = "Toggle Breakpoint",
	},
	{
		"<leader>dB",
		function()
			require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end,
		desc = "Conditional Breakpoint",
	},
	{
		"<leader>dC",
		function()
			require("dap").clear_breakpoints()
		end,
		desc = "Clear All Breakpoints",
	},
	{
		"<leader>dn",
		function()
			require("dap").step_over()
		end,
		desc = "Step Over",
	},
	{
		"<leader>di",
		function()
			require("dap").step_into()
		end,
		desc = "Step Into",
	},
	{
		"<leader>do",
		function()
			require("dap").step_out()
		end,
		desc = "Step Out",
	},
	{
		"<leader>dl",
		function()
			require("dap").run_last()
		end,
		desc = "Run Last Debug Session",
	},
	{
		"<leader>dq",
		function()
			require("dap").terminate()
			require("dapui").close()
		end,
		desc = "Quit Debugger",
	},
})
