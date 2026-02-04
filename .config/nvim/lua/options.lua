-- remove stupid autocommenting behavior
-- Set the global default

vim.opt.formatoptions:remove "c"
vim.opt.formatoptions:remove "r"
vim.opt.formatoptions:remove "o"

-- Ensure ftplugins don't re-enable it per-buffer
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("NoCommentContinue", { clear = true }),
  desc = "Disable comment continuation (fo-=cro)",
  callback = function()
    vim.opt_local.formatoptions:remove "c"
    vim.opt_local.formatoptions:remove "r"
    vim.opt_local.formatoptions:remove "o"
  end,
})

return {
  opt = {
    formatoptions = vim.opt.formatoptions:get():gsub("c", ""):gsub("r", ""):gsub("o", ""),
  },
}
