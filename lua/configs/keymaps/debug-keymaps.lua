local wk = require("which-key")

wk.add({
	mode = "n",
	{ "<leader>d", group = "Debug" },
	{
		"<leader>do",
		function()
			require("dapui").open()
		end,
		desc = "Open Debugger UI",
	},
	{
		"<leader>dc",
		function()
			require("dapui").close()
		end,
		desc = "Continue Execution",
	},
	{
		"<leader>ds",
		function()
			require("dap").continue()
		end,
		desc = "Start/Continue Debugging",
	},
	{
		"<leader>db",
		function()
			require("dap").toggle_breakpoint()
		end,
		desc = "Toggle Breakpoint",
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
