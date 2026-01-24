local files_helper = require("helpers.files-helpers")
local wk = require("which-key")

local function ReplaceTabs()
	local bufnr = vim.api.nvim_get_current_buf()
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local comment_patterns = {
		lua = "%-%-",
		python = "#",
		javascript = "//",
		javascriptreact = "//",
		typescript = "//",
		typescriptreact = "//",
		c = "//",
		cpp = "//",
		rust = "//",
		go = "//",
		sh = "#",
		bash = "#",
		vim = '"',
	}

	local ft = vim.bo.filetype
	local pattern = comment_patterns[ft] or "#"

	local result = {}
	local pending = ""

	for _, line in ipairs(lines) do
		local no_tabs = line:gsub("\t", "")

		if no_tabs == "" then
			if pending ~= "" then
				table.insert(result, pending)
				pending = ""
			end
			table.insert(result, "")
		else
			local has_comment = no_tabs:match(pattern)

			if has_comment then
				if pending ~= "" then
					table.insert(result, pending)
					pending = ""
				end
				table.insert(result, no_tabs)
			else
				if pending ~= "" then
					pending = pending .. " " .. no_tabs
				else
					pending = no_tabs
				end
			end
		end
	end

	if pending ~= "" then
		table.insert(result, pending)
	end

	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, result)
end

wk.add({
	mode = "n",
	{
		"<leader>r",
		group = "Replace",
	},
	{
		"<leader>ro",
		function()
			local flags = {}

			local is_dotfiles = files_helper.is_dotfiles()
			if is_dotfiles then
				table.insert(flags, "--hidden")
			end

			local concat_flags = table.concat(flags, " ")

			require("grug-far").open({
				prefills = {
					flags = concat_flags,
				},
			})
		end,
		desc = "Open Spectre",
	},
	{
		"<leader>rw",
		[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
		desc = "Replace Word Under Cursor",
	},
	{
		"<leader>rc",
		function()
			ReplaceTabs()
		end,
		desc = "Replace tabs with spaces and join lines with spaces",
	},
	{
		"<leader>rpv",
		function()
			require("grug-far").open({
				prefills = {
					search = ': "\\^',
					replacement = ': "',
					filesFilter = "package.json",
				},
			})
		end,
		desc = "Remove all ^ from package.json versions",
	},
})

wk.add({
	mode = "x",
	{
		"<leader>r",
		group = "Replace",
	},
	{
		"<leader>ro",
		function()
			local cwd = vim.fn.getcwd()
			require("grug-far").with_visual_selection({
				prefills = {
					paths = cwd,
					flags = files_helper.is_dotfiles and "--hidden" or nil,
				},
			})
		end,
		desc = "Open Grug-FAR with visual selection",
	},
})
