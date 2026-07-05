-- ######### INSTALLATION #########

vim.pack.add({
	{ src = "https://github.com/folke/lazydev.nvim" },
	{ src = "https://github.com/DrKJeff16/wezterm-types" },
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1") },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/L3MON4D3/LuaSnip", version = "v2.4.0", name = "LuaSnip" },
	{ src = "https://github.com/fang2hou/blink-copilot" },
})

-- ######### CONFIG #########
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(event)
		local plugin = event.data.spec.name
		local kind = event.data.kind

		if plugin ~= "LuaSnip" or (kind ~= "install" and kind ~= "update") then
			return
		end

		vim.system({ "make", "install_jsregexp" }, { cwd = event.data.path }):wait()
	end,
})

local lazydev_provider = {
	default = "lazydev",
	provider = {
		name = "LazyDev",
		module = "lazydev.integrations.blink",
		score_offset = 100,
	},
}

local copilot_provider = {
	default = "copilot",
	provider = {
		name = "copilot",
		module = "blink-copilot",
		score_offset = 100,
		async = true,
	},
}

require("lazydev").setup({
	library = {
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		{ path = "wezterm-types", words = { "wezterm" } },
	},
})

require("luasnip.loaders.from_vscode").lazy_load()

require("blink.cmp").setup({
	sources = {
		default = {
			copilot_provider.default,
			"lsp",
			lazydev_provider.default,
			"path",
			"snippets",
			"buffer",
		},
		providers = {
			lazydev = lazydev_provider.provider,
			copilot = copilot_provider.provider,
		},
	},
	completion = {
		documentation = { auto_show = true },
		list = { selection = { preselect = false } },
	},
	keymap = {
		preset = "default",
		["<CR>"] = { "accept", "fallback" },
		["<C><leader>"] = { "show" },
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
