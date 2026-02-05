local function run_lua_file()
	if vim.bo.filetype ~= "lua" then
		vim.notify("RunLuaFile: current buffer is not a Lua file", vim.log.levels.WARN)
		return
	end

	local file = vim.api.nvim_buf_get_name(0)
	if file == "" then
		vim.notify("RunLuaFile: buffer has no file name", vim.log.levels.WARN)
		return
	end

	vim.cmd("luafile " .. vim.fn.fnameescape(file))
end

vim.api.nvim_create_user_command("RunLuaFile", run_lua_file, {})
