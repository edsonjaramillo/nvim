-- ######### INSTALLATION #########
vim.pack.add({
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/folke/noice.nvim" },
})

-- ######### CONFIG #########
require("snacks").setup({
	notifier = {
		enabled = true,
		timeout = 1500,
		date_format = "%-I:%M:%S %p",
	},
	picker = {
		enabled = true,
		ui_select = true,
		sources = {
			files = { hidden = true },
			grep = { hidden = true },
			grep_word = { hidden = true },
		},
	},
	terminal = { enabled = true },
})

local colors = {
	Error = "#e35659",
	Warn = "#f8cc5a",
	Info = "#409cff",
	Debug = "#aeaeae",
}

for level, color in pairs(colors) do
	for _, part in ipairs({ "Border", "Icon", "Title" }) do
		vim.api.nvim_set_hl(0, "SnacksNotifier" .. part .. level, { fg = color })
	end
end

require("noice").setup({
	-- blink.cmp handles signature help (see completion.lua); turn Noice's off
	-- so two signature popups don't show at the same time.
	lsp = { signature = { enabled = false } },
})
