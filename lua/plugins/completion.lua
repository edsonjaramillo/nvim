-- ######### INSTALLATION #########

vim.pack.add({
	{ src = "https://github.com/folke/lazydev.nvim" },
	{ src = "https://github.com/DrKJeff16/wezterm-types" },
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1") },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/xzbdmw/colorful-menu.nvim" },
})

-- ######### CONFIG #########

local local_plugins = vim.fn.globpath(vim.fn.expand("~/code/plugins"), "*", false, true)

require("lazydev").setup({
	library = vim.list_extend({
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		{ path = "wezterm-types", words = { "wezterm" } },
	}, local_plugins),
})

require("colorful-menu").setup({})

require("blink.cmp").setup({
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
		per_filetype = {
			lua = { inherit_defaults = true, "lazydev" },
		},
		providers = {
			lazydev = {
				name = "LazyDev",
				module = "lazydev.integrations.blink",
				score_offset = 100, -- rank lazydev items above plain LSP items
			},
			snippets = {
				should_show_items = function(ctx)
					return ctx.trigger.initial_kind ~= "trigger_character"
				end,
			},
		},
	},
	signature = {
		enabled = true,
		window = { border = "rounded" },
	},
	completion = {
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
			window = { border = "rounded" },
		},
		menu = {
			border = "rounded",
			draw = {
				columns = {
					{ "kind_icon" },
					{ "label", gap = 1 },
					{ "kind" },
				},
				components = {
					label = {
						text = function(ctx)
							return require("colorful-menu").blink_components_text(ctx)
						end,
						highlight = function(ctx)
							return require("colorful-menu").blink_components_highlight(ctx)
						end,
					},
				},
			},
		},
		list = { selection = { preselect = false } },
		ghost_text = {
			enabled = true,
			show_without_selection = true,
		},
	},
	cmdline = {
		keymap = { preset = "inherit" },
		completion = {
			menu = { auto_show = true },
			list = { selection = { preselect = false } },
		},
	},
	keymap = {
		preset = "default",
		["<CR>"] = { "accept", "fallback" },
		["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
		["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
		["<UP>"] = { "fallback" },
		["<DOWN>"] = { "fallback" },
	},
	fuzzy = { implementation = "prefer_rust_with_warning" },
})
