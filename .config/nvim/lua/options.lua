-- remove stupid autocommenting behavior
return {
  opt = {
    formatoptions = vim.opt.formatoptions:get()
      :gsub("c", "")
      :gsub("r", "")
      :gsub("o", "")
  },
}
