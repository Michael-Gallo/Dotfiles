vim.keymap.set("n", "<C-/>",
    function() require('Comment.api').toggle.linewise.current() end,
    { noremap = true, silent = true })
