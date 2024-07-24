vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set termguicolors")
vim.g.mapleader = " "

local opt = vim.o
opt.relativenumber = true

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jkjk", "<ESC>", { desc = "exit insert mode" })

-- have ctrl-s in normal mode save the file and also in insert mode
keymap.set("n", "<C-s>", ":update<CR>", { desc = "Save file" })
keymap.set("i", "<C-s>", "<ESC>:update<CR>a", { desc = "Save file" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

