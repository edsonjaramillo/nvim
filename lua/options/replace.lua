vim.api.nvim_set_keymap('n', '<Leader>r', [[:lua ReplaceWordUnderCursor()<CR>]], { noremap = true, silent = true })
function ReplaceWordUnderCursor()
    local old_word = vim.fn.expand('<cword>')
    -- Escape special regex characters in the old word
    old_word = vim.fn.escape(old_word, '\\/.*$^~[]')
    local new_word = vim.fn.input('Replace ' .. old_word .. ' with: ')
    if new_word == '' then
        print('No replacement word provided. Operation cancelled.')
        return
    end
    -- Use the 'c' flag for confirmation on each replacement
    local cmd = ':%s/\\<' .. old_word .. '\\>/' .. vim.fn.escape(new_word, '\\/.*$^~[]') .. '/gc'
    vim.cmd(cmd)
    -- Clear the command-line
    vim.cmd('redraw!')
end
