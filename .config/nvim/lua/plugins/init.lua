return {
{
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
     quickfile = { enabled = true },
     terminal  = {
        enabled = true,
        win = {
          style = "terminal",
          border = vim.g.border_style,
          position = "bottom",
          height = 0.4,
          width = 0.8,
        },
     },
     bigfile   = { enabled = true },
     indent    = { enabled = true },
     picker    = {
                enabled = true ,sources = {
                    explorer= {
                        enabled = true,
                        replace_netrw = true,
                    },
                }
                },
     explorer = { enabled = true, replace_netrw = true },
     statuscolumn = { enabled = true },
     input = { enabled = true },
  -- notifier = { enabled = true },
  -- scope = { enabled = true },
  -- scroll = { enabled = true },
  -- words = { enabled = true },
  -- dashboard = { enabled = true },
  },
    keys={
    {"<c-`>", function() Snacks.terminal.toggle() end,mode= {'n','t'}, desc = "Toggle Terminal"} ,
    { "<leader>pv", function() Snacks.explorer() end, desc = "File Explorer" },
    { "<leader>pb", function() Snacks.picker.buffers() end, desc = "Buffers Browser" },


    },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.dim():map("<leader>uD")
      end,
    })
  end,

},
	'nvim-telescope/telescope.nvim',
    'folke/which-key.nvim',
	  --  opts = {
	  --      defaults = {
	  --         -- ["<leader>p"] = { name = "+file operations" },
	  --          ["<leader>g"] = { name = "+git" },
	  --      }
	  --   },
	  --   config = function (_, opts)
	  --    local wk = require("which-key")
	  -- wk.setup(opts)
	  -- wk.register(opts.defaults)
	  --   end
	  --  },
	'Mofiqul/dracula.nvim',
	{'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
	'theprimeagen/harpoon',
	'mbbill/undotree',
	'tpope/vim-fugitive',
	{'VonHeikemen/lsp-zero.nvim', branch = 'v4.x'},
	{'neovim/nvim-lspconfig'},
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/nvim-cmp'},
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
    { 'echasnovski/mini.nvim', version = false },
    "nvim-tree/nvim-web-devicons",
    "github/copilot.vim",
}
