-- ######### INSTALLATION #########
vim.pack.add({
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/rcarriga/nvim-notify" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/folke/noice.nvim" },
})

-- ######### CONFIG #########
local colors = {
	ERROR = "#e35659",
	WARN = "#f8cc5a",
	INFO = "#409cff",
	DEBUG = "#aeaeae",
}

local highlights = { "Border", "Icon", "Title" }

vim.notify = require("notify")
for _, highlight in ipairs(highlights) do
	for level, color in pairs(colors) do
		vim.api.nvim_set_hl(0, "Notify" .. level .. highlight, { fg = color })
	end
end

require("notify").setup({
	merge_duplicates = true,
	background_colour = "#030303",
	time_formats = {
		notification = "%-I:%M:%S %p",
	},
	timeout = 1000,
})

require("noice").setup()
