return {
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
	{'nvim-treesitter/nvim-treesitter', build = 'TSUpdate'},
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
    "nvim-tree/nvim-web-devicons"


}
