-- ######### INSTALLATION #########
vim.pack.add({
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/windwp/nvim-ts-autotag" },
	{ src = "https://github.com/yutkat/confirm-quit.nvim" },
	{ src = "https://github.com/max397574/better-escape.nvim" },
})

-- ######### CONFIG #########
require("nvim-autopairs").setup()
require("nvim-ts-autotag").setup()
require("confirm-quit").setup()
require("better_escape").setup({
	timeout = vim.o.timeoutlen,
	default_mappings = false,
	mappings = {
		i = { j = { k = "<Esc>" }, k = { j = "<Esc>" } },
		s = { j = { k = "<Esc>" }, k = { j = "<Esc>" } },
		c = { j = { k = "<C-c>" }, k = { j = "<C-c>" } },
	},
})
