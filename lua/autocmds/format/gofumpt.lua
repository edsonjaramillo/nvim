local go = require("abide").Abide:new("gofumpt")

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.go" },
	callback = function()
		local filetype = go:get_filetype()

		local filetypes = {
			"go",
		}

		if not go:check_filetypes(filetype, filetypes) then
			return
		end

		if not go:check_executable() then
			return
		end

		local stdin = go:get_buffer_lines()

		local argv = { "gofumpt", "--" }

		local bufnr = go:get_bufnr()
		go:command({
			bufnr = bufnr,
			argv = argv,
			stdin = stdin,
			has_config = false,
		})
	end,
})
