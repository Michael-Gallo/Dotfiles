local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

vim.keymap.set('n', "<leader>a", mark.add_file, {desc="add file to Harpoon"})
vim.keymap.set('n', "<C-e>", ui.toggle_quick_menu, {desc="toggle Harpoon Quick Menu"})
vim.keymap.set('n', "<C-h>", function() ui.nav_file(1) end, {desc = "navigate to Harpoon file 1"})
vim.keymap.set('n', "<C-t>", function() ui.nav_file(2) end, {desc = "navigate to Harpoon file 1"})



