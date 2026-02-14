return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    opts.formatters_by_ft = opts.formatters_by_ft or {}
    opts.formatters_by_ft.markdown = { "prettier" }

    opts.format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    }

    return opts
  end,
}
