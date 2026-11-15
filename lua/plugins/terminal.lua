-- ######### CONFIG #########
local snacks = require("snacks")

---@type snacks.terminal.Opts
local terminal_opts = {
	win = {
		-- VSCode-style bottom panel: ~30% of the editor height
		position = "bottom",
		height = 0.3,
		wo = {
			signcolumn = "no",
			number = false,
			relativenumber = false,
			winfixheight = true,
		},
		-- Use the global <Esc><Esc> mapping below instead of snacks' version
		keys = { term_normal = false },
	},
}

-- Keep a single terminal instance, even if the cwd changes
---@type snacks.win?
local basic_terminal

local function toggle_terminal()
	if basic_terminal and basic_terminal:buf_valid() then
		basic_terminal:toggle()
	else
		basic_terminal = snacks.terminal.open(nil, terminal_opts)
	end
end

-- ######### KEYMAPS #########
local wk = require("which-key")

wk.add({
	mode = "n",
	{
		"<leader>t",
		group = "Terminal",
	},
	{
		"<leader>tt",
		toggle_terminal,
		desc = "Toggle Terminal",
	},
})

-- VSCode-style Ctrl+` toggle (works from normal, insert and terminal mode).
-- Many terminal emulators send Ctrl+` as <C-@> (NUL), so map both.
for _, lhs in ipairs({ "<C-`>", "<C-@>" }) do
	vim.keymap.set({ "n", "i", "t" }, lhs, toggle_terminal, { desc = "Toggle Terminal" })
end

-- Leave terminal mode with <Esc><Esc>, and move between windows with <C-hjkl>
vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], { desc = "Window left" })
vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], { desc = "Window down" })
vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], { desc = "Window up" })
vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], { desc = "Window right" })
