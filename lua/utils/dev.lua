local M = {
	enabled = false,
}

local function notify(msg, level)
	vim.notify(msg, level, { title = "dev" })
end

function M.is_enabled()
	return M.enabled
end

function M.enable()
	M.enabled = true
	notify("debug enabled", vim.log.levels.INFO)
end

function M.disable()
	M.enabled = false
	notify("debug disabled", vim.log.levels.INFO)
end

function M.toggle()
	if M.enabled then
		M.disable()
	else
		M.enable()
	end
end

function M.info(msg)
	if not M.enabled then
		return
	end

	notify(msg, vim.log.levels.INFO)
end

function M.warn(msg)
	if not M.enabled then
		return
	end

	notify(msg, vim.log.levels.WARN)
end

function M.error(msg)
	notify(msg, vim.log.levels.ERROR)
end

function M.dump(label, value, level)
	if not M.enabled then
		return
	end

	local prefix = label and (label .. ": ") or ""
	notify(prefix .. vim.inspect(value), level or vim.log.levels.DEBUG)
end

return M
