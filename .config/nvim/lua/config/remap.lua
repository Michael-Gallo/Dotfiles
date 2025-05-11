vim.g.mapleader = " "

-- Better moving
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")


vim.keymap.set("n","J","mzJ`z",{desc="cursor stays in same place with J"})

vim.keymap.set("n", "<C-d>", "C-d>zz",{desc="stay in middle when doing half page moves down"})
vim.keymap.set("n", "<C-u>", "C-u>zz",{desc="stay in middle when doing half page moves up"})

vim.keymap.set("n","n","nzzzv",{desc="keep cursor in middle while searching"})
vim.keymap.set("n","N","Nzzzv",{desc="keep cursor in middle while searching"})


vim.keymap.set("x", "<leader>p", "\"_dP", {desc="paste without overwriting register"})

vim.keymap.set("n","<leader>x","<cmd>!chmod +x %<CR>", {silent = true, desc = "set current file to executable"})


vim.keymap.set("n", "<leader><leader>", function()
        vim.cmd("so")
end, {desc = "source current file"})


-- Ctrl + W breaks out of terminal mode and sends a normal Ctrl + W to enable window operations
vim.api.nvim_set_keymap(
    't',
    '<C-w>',
    [[<C-\><C-n><C-w>]],
    { noremap = true, silent = true }
)
