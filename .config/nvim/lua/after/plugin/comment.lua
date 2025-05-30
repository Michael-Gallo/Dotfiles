comment_api = require('Comment.api')
require('Comment').setup({
    opleader = {
        line="<C-/>",
    },
    toggler ={
        line = "<C-/>"
    }
})
vim.keymap.set({'n'}, "<C-_>",
    function() comment_api.toggle.linewise.current() end,
    { noremap = true, silent = true })
