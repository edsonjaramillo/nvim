local languages = require("utils.parsers")

vim.api.nvim_create_autocmd("FileType", {
	pattern = languages.filetypes,
	callback = function(o)
		vim.treesitter.start()
	end,
})
