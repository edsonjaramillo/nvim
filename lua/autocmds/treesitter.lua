local languages = require("utils.languages")

vim.api.nvim_create_autocmd("FileType", {
	pattern = languages.filetypes,
	callback = function(o)
		vim.treesitter.start()
	end,
})
