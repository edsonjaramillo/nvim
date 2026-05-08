local dev = require("utils.dev")

-- Return to last cursor position when reopening filetypes
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Reload file if changed outside of nvim
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	command = "checktime",
})

vim.api.nvim_create_user_command("RunFile", function()
	local path = vim.api.nvim_buf_get_name(0)
	if path == "" then
		vim.notify("RunFile requires a named Lua buffer", vim.log.levels.WARN)
		return
	end

	if vim.bo.filetype ~= "lua" then
		vim.notify("RunFile only supports Lua buffers", vim.log.levels.WARN)
		return
	end

	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local chunk, load_err = load(table.concat(lines, "\n"), "@" .. path)
	if not chunk then
		vim.notify("RunFile load failed: " .. load_err, vim.log.levels.ERROR)
		return
	end

	local ok, result = xpcall(chunk, debug.traceback)
	if not ok then
		vim.notify("RunFile failed:\n" .. result, vim.log.levels.ERROR)
		return
	end

	vim.notify("RunFile executed: " .. vim.fn.fnamemodify(path, ":~:."), vim.log.levels.INFO)
end, {
	desc = "Run the current Lua buffer inside Neovim",
})

vim.api.nvim_create_user_command("DevToggle", function()
	dev.toggle()
end, {
	desc = "Toggle development debug notifications",
})
