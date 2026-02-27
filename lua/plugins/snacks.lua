local files_helper = require("helpers.files-helpers")
local fzf = require("fzf-lua")
local oil_helper = require("helpers.oil-helpers")
local snacks_helper = require("helpers.snacks-helpers")

---@module 'lazy'
---@type LazySpec[]
return {
	{
		"folke/snacks.nvim",
		opts = {
			picker = {},
			dashboard = {
				preset = {
					keys = {
						{
							icon = " ",
							key = "f",
							desc = "Find File",
							action = function()
								require("snacks").picker.files({
									hidden = files_helper.is_dotfiles,
									exclude = snacks_helper.folder_exclude,
								})
							end,
						},
						{
							icon = "󰈞 ",
							key = "r",
							desc = "Recent Files",
							action = function()
								require("snacks").picker.recent({
									filter = { paths = snacks_helper.priotize_cwd },
									matcher = { cwd_bonus = true },
								})
							end,
						},
						{
							icon = "󰍉 ",
							key = "g",
							desc = "Live Grep",
							action = function()
								require("snacks").picker.grep({
									hidden = files_helper.is_dotfiles,
									matcher = { cwd_bonus = true },
								})
							end,
						},
						{
							icon = "󰊢 ",
							key = "s",
							desc = "Git Status",
							action = function()
								require("fzf-lua").git_status()
							end,
						},
						{
							icon = "󰉓 ",
							key = "e",
							desc = "File Explorer",
							action = "<cmd>Yazi<cr>",
						},
						{
							icon = "󰒲 ",
							key = "L",
							desc = "Lazy",
							action = ":Lazy",
							enabled = package.loaded.lazy ~= nil,
						},
						{
							icon = " ",
							key = "q",
							desc = "Quit",
							action = ":qa",
						},
					},
				},
			},
		},
	},
}
