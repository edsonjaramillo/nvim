--- Module for managing Tree-sitter parsers and their corresponding filetypes
---@class LangUtils
---@field common string[]
---@field tree_sitter string[]
---@field filetypes string[]
local M = {}

--- Tree-sitter parsers and filetypes that share a name in common
---@type string[]
M.common = {
	"bash",
	"c",
	"cpp",
	"css",
	"csv",
	"dockerfile",
	"gitcommit",
	"gitignore",
	"go",
	"gomod",
	"graphql",
	"html",
	"javascript",
	"json",
	"lua",
	"markdown",
	"nix",
	"python",
	"sql",
	"tmux",
	"toml",
	"typescript",
	"vim",
	"vimdoc",
	"yaml",
	"zsh",
}

--- Tree-sitter parsers that have different names than their filetypes
---@type string[]
M.tree_sitter = vim.list_extend(M.common, {
	"c_sharp",
	"caddy",
	"git_config",
	"gosum",
	"jsdoc",
	"tsx",
})

--- Filetypes that have different names than their tree-sitter parsers
---@type string[]
M.filetypes = vim.list_extend(M.common, {
	"cs",
	"gitconfig",
	"javascript.jsx",
	"javascriptreact",
	"jsonc",
	"sh",
	"typescript.tsx",
	"typescriptreact",
})

return M
