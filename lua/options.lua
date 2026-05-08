local g = vim.g
g.mapleader = " "
g.maplocalleader = ","

local o = vim.opt

o.relativenumber = true
o.cursorline = true
o.signcolumn = "yes"
o.wrap = false
o.linebreak = true
o.scrolloff = 8
o.sidescrolloff = 8
o.termguicolors = true
o.laststatus = 3
o.showmode = false

o.list = true
o.listchars = {
	tab = "» ",
	trail = "·",
	extends = "›",
	precedes = "‹",
	nbsp = "␣",
}
o.fillchars = {
	eob = " ",
	fold = " ",
	foldsep = " ",
	vert = "│",
}

o.splitright = true
o.splitbelow = true
o.equalalways = false

o.tabstop = 4
o.shiftwidth = 4
o.smartindent = true
o.shiftround = true
o.smarttab = true

o.ignorecase = true
o.smartcase = true
o.incsearch = true
o.hlsearch = true

o.completeopt = { "menu", "menuone", "noselect" }
o.pumheight = 10
o.shortmess:append("c")
o.updatetime = 200
o.timeoutlen = 400

o.undofile = true
o.swapfile = false
o.backup = false
o.writebackup = false

o.clipboard = "unnamedplus"
o.mouse = "a"

o.foldenable = true
o.foldlevel = 99
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
if vim.fn.exists("*nvim_treesitter#foldexpr") == 0 then
	o.foldexpr = "0"
end

o.backspace = { "indent", "eol", "start" }
o.confirm = true
o.hidden = true
o.fileencoding = "utf-8"
o.spell = false

o.breakindent = true
o.inccommand = "nosplit"
o.startofline = false
o.whichwrap = "h,l,<>[]"

o.guicursor = table.concat({
	"n:block-Cursor/lCursor",
	"v:block-VisualCursor/lCursor",
	"V:block-VisualCursor/lCursor",
	"i-ci:ver25-iCursor/lCursor",
	"r-cr:vej25-ReplaceCursor/lCursor",
}, ",")

local sethl = vim.api.nvim_set_hl
sethl(0, "Cursor", { fg = "#030303", bg = "#fafafa" })
sethl(0, "lCursor", { fg = "#030303", bg = "#fafafa" })
sethl(0, "VisualCursor", { fg = "#030303", bg = "#409cff" })
sethl(0, "iCursor", { fg = "#030303", bg = "#24d064" })
sethl(0, "ReplaceCursor", { fg = "#030303", bg = "#e35659" })
