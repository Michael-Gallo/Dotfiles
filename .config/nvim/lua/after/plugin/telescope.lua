local builtin = require('telescope.builtin')
vim.keymap.set('n','<leader>pf', builtin.find_files, {desc="Find files"})
vim.keymap.set('n','<leader>pg',builtin.git_files,{desc="Find Git files"})
vim.keymap.set('n','<leader>ps', function()
	builtin.live_grep( {});
end,{desc="Grep through files"})
