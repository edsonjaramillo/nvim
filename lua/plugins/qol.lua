-- ######### INSTALLATION #########
vim.pack.add({
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/windwp/nvim-ts-autotag" },
	{ src = "https://github.com/yutkat/confirm-quit.nvim" },
})

-- ######### CONFIG #########
require("nvim-autopairs").setup()
require("nvim-ts-autotag").setup()
require("confirm-quit").setup()

-- ######### KEYMAPS #########
local esc_keys = { "jk", "kj" }
for _, key in ipairs(esc_keys) do
	vim.keymap.set({ "i", "s", "c" }, key, "<Esc>", {
		noremap = true,
		silent = true,
		desc = "Exit to Normal mode",
	})
end
