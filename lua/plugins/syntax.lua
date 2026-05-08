-- ######### INSTALLATION #########
vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/artemave/workspace-diagnostics.nvim" },
})

-- https://github.com/nvim-treesitter/nvim-treesitter/blob/main/SUPPORTED_LANGUAGES.md
local parser_languages = {
	"bash",
	"c",
	"c_sharp",
	"caddy",
	"cpp",
	"css",
	"csv",
	"dockerfile",
	"git_config",
	"gitcommit",
	"gitignore",
	"go",
	"gomod",
	"gosum",
	"graphql",
	"html",
	"javascript",
	"jsdoc",
	"json",
	"lua",
	"markdown",
	"nix",
	"python",
	"sql",
	"tmux",
	"toml",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
	"yaml",
	"zsh",
}

-- ######### CONFIG #########
require("nvim-treesitter").install(parser_languages)
