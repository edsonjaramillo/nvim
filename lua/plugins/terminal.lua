-- ######### INSTALLATION #########
vim.pack.add({
	{ src = "https://github.com/akinsho/toggleterm.nvim" },
})

-- ######### CONFIG #########
local toggleterm = require("toggleterm")
toggleterm.setup({
	hide_numbers = true,
	-- VSCode-style bottom panel: ~30% of the editor height
	size = function(term)
		if term.direction == "horizontal" then
			return math.floor(vim.o.lines * 0.3)
		end
		return 20
	end,
	shade_terminals = false,
	start_in_insert = true,
	persist_size = true,
	persist_mode = true,
})

local terminal = require("toggleterm.terminal").Terminal

local basic_terminal = terminal:new({
	hidden = true,
	direction = "horizontal",
	on_open = function(term)
		vim.cmd("startinsert!")
		-- Window-only options so it looks like a panel
		vim.wo[term.window].signcolumn = "no"
		vim.wo[term.window].winfixheight = true
	end,
})

local function toggle_terminal()
	basic_terminal:toggle()
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
