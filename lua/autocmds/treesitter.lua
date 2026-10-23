vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
	callback = function(event)
		local lang = vim.treesitter.language.get_lang(event.match) or event.match
		if not vim.treesitter.language.add(lang) then
			return
		end

		pcall(vim.treesitter.start, event.buf, lang)
	end,
})
