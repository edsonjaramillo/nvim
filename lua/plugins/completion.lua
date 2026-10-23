-- ######### INSTALLATION #########

vim.pack.add({
	{ src = "https://github.com/folke/lazydev.nvim" },
	{ src = "https://github.com/DrKJeff16/wezterm-types" },
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1") },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/L3MON4D3/LuaSnip", version = "v2.4.0", name = "LuaSnip" },
})

-- ######### CONFIG #########

local lazydev_provider = {
	default = "lazydev",
	provider = {
		name = "LazyDev",
		module = "lazydev.integrations.blink",
		score_offset = 100,
	},
}

local local_plugins = vim.fn.globpath(vim.fn.expand("~/code/plugins"), "*", false, true)

require("lazydev").setup({
	library = vim.list_extend({
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		{ path = "wezterm-types", words = { "wezterm" } },
	}, local_plugins),
})

require("blink.cmp").setup({
	sources = {
		default = {
			"lsp",
			lazydev_provider.default,
			"path",
			"snippets",
			"buffer",
		},
		providers = {
			lazydev = lazydev_provider.provider,
		},
	},
	completion = {
		documentation = { auto_show = true },
		list = { selection = { preselect = false } },
	},
	keymap = {
		preset = "default",
		["<CR>"] = { "accept", "fallback" },
		["<Tab>"] = { "select_next", "fallback" },
		["<S-Tab>"] = { "select_prev", "fallback" },
		["<UP>"] = { "fallback" },
		["<DOWN>"] = { "fallback" },
	},
	appearance = {
		nerd_font_variant = "mono",
	},
	fuzzy = { implementation = "prefer_rust_with_warning" },
})
