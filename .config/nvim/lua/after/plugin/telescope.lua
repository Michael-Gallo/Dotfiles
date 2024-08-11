local builtin = require('telescope.builtin')
vim.keymap.set('n',"<leader>p",function() end,{desc="file operations"})
vim.keymap.set('n','<leader>pf', builtin.find_files, {desc="Find files"})
vim.keymap.set('n','<C-p>',builtin.git_files,{desc="Find Git files"})
vim.keymap.set('n','<leader>ps', function()
	builtin.grep_string( {search = vim.fn.input("Grep > ") });
end,{desc="Grep through files"})
