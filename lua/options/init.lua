vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set termguicolors")
vim.g.mapleader = " "

local opt = vim.o
opt.relativenumber = true

require("options.mappings")
require("options.replace")
