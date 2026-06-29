local M = {}

local function is_tsx_buffer()
	return vim.bo.filetype == "typescriptreact"
		or vim.bo.filetype == "tsx"
		or vim.fn.expand("%:e") == "tsx"
end

local function remove_tsx_space_literals()
	local changed = false

	for line_number = 1, vim.api.nvim_buf_line_count(0) do
		local line = vim.api.nvim_buf_get_lines(0, line_number - 1, line_number, false)[1]
		local updated_line = line:gsub('{" "}', "")

		if updated_line ~= line then
			changed = true
			vim.api.nvim_buf_set_lines(0, line_number - 1, line_number, false, { updated_line })
		end
	end

	return changed
end

function M.remove_tabs()
	local view = vim.fn.winsaveview()

	for line_number = vim.api.nvim_buf_line_count(0), 2, -1 do
		local current_line = vim.api.nvim_buf_get_lines(0, line_number - 1, line_number, false)[1]
		local previous_line =
			vim.api.nvim_buf_get_lines(0, line_number - 2, line_number - 1, false)[1]

		if current_line:sub(1, 1) == "\t" and previous_line:match("%S") then
			vim.api.nvim_buf_set_lines(0, line_number - 2, line_number, false, {
				previous_line .. current_line:sub(2),
			})
		end
	end

	vim.cmd("silent write")

	if is_tsx_buffer() then
		local changed = remove_tsx_space_literals()

		if changed then
			vim.cmd("silent noautocmd write")
		end
	end

	vim.fn.winrestview(view)
end

return M
