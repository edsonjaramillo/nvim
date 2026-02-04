local home = vim.env.HOME or ""
if home == "" then
	vim.notify("HOME environment variable is not set", vim.log.levels.ERROR)
	return
end

local plugins_path = home .. "/code/plugins/**/*.lua"
local nvim_config_path = home .. "/.config/nvim/**/*.lua"

local patterns = { plugins_path, nvim_config_path }

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = patterns,
	desc = "Auto-source Lua config on save",
	callback = function(s)
		-- if filename is dev.lua do not source the file
		if s.file:match("dev.lua$") then
			return
		end

		vim.cmd.source({ args = { s.file } })

		local display_path = s.file:gsub(home, "~")
		vim.notify("Reloaded " .. display_path, vim.log.levels.INFO)
	end,
})
