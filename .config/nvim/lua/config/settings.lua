vim.opt.relativenumber = true
vim.opt.nu= true
vim.cmd.colorscheme("dracula")

vim.opt.guicursor=""

vim.opt.tabstop =4
vim.opt.softtabstop=4
vim.opt.shiftwidth=4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.hlsearch = false
vim.opt.incsearch = true


vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.termguicolors = true

vim.opt.scrolloff = 5
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50

vim.opt.clipboard:append { 'unnamed', 'unnamedplus' }
