local plugins = {

  {
    dir = "~/Projects/sudoku.nvim",
    cmd = "Sudoku",
    config = function()
      require("sudoku").setup({
        custom_highlights = {
          square = { fg = "red" }
        }
      })
      vim.cmd("hi SudokuSquare guibg=red")
    end
  },

  "nvim-lua/plenary.nvim",

  ---------------------
  -- Theming Section --
  ---------------------

  require("max.theme"),

  --------------------
  -- Layout Plugins --
  --------------------
  "nvim-lua/popup.nvim",
  require("max.configs.neotree"),
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    config = function()
      require("max.configs.lualine")
    end,
  },
  {
    'echasnovski/mini.nvim',
    version = false,
    event = "VeryLazy",
    config = function()
      -- require("mini.sessions").setup({
      --   autoread = true,
      --   directory = "session",
      --   file = "",
      --   verbose = { read = true, write = true, delete = true },
      -- })

      require("mini.comment").setup({
      })

      require("mini.pairs").setup({
      })

      require("mini.surround").setup({
      })

      require("mini.animate").setup({
        cursor = {
          enable = false,
        }
      })
    end
  },
  {
    "shortcuts/no-neck-pain.nvim",
    cmd = "NoNeckPain",
    config = true
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    enabled = true,
    opts = {
      lsp = {
        progress = {
          enabled = false
        },
        hover = {
          enabled = false
        }
      },
      views = {
        cmdline_popup = {
          border = {
            style = "single",
            padding = { 0, 1 },
          },
          filter_options = {},
          win_options = {
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
          },
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true
      },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup({})
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    config = true,
  },
  { "mbbill/undotree", cmd = { "Undotree", "UndotreeToggle" } },
  {
    "petertriho/nvim-scrollbar",
    event = "VeryLazy",
    config = function()
      require("max.configs.scrollbar")
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPost",
    config = function()
      require("gitsigns").setup()
    end,
  },
  {
    "akinsho/nvim-toggleterm.lua",
    event = "VeryLazy",
    config = function()
      require("max.configs.toggleterm");
    end,
  },
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    event = "BufReadPost",
    config = function()
      require("git-conflict").setup()
    end,
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      require("max.configs.notify")
    end,
    event = "VimEnter",
  },
  {
    "goolord/alpha-nvim",
    lazy = false,
    config = function()
      require("max.configs.dashboard")
    end,
  }, -- startup screen
  ---------------------
  -- Code Navigation --
  ---------------------
  {
    "ggandor/flit.nvim",
    dependencies = {
      "ggandor/leap.nvim",
    },
    event = "VeryLazy",
    config = true,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    event = "VeryLazy",
    config = function()
      require("max.configs.telescope")
    end,
  },
  ---------------
  -- Lsp Setup --
  ---------------
  {
    "glepnir/lspsaga.nvim",
    event = "BufRead",
    config = function()
      require("lspsaga").setup({
        symbol_in_winbar = {
          enable = false,
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "arkav/lualine-lsp-progress",
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
      "williamboman/mason-lspconfig.nvim",
      "onsails/lspkind.nvim",
      { "lukas-reineke/lsp-format.nvim", config = true },
    },
    event = "BufReadPost",
    config = function()
      require("max.configs.lsp")
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup({})
    end,
  },
  -------------------
  --  Autocomplete --
  -------------------
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-emoji",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "zbirenbaum/copilot.lua",
      "zbirenbaum/copilot-cmp",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("max.configs.autocomplete")
    end,
  },
  {
    "nat-418/boole.nvim",
    event = "InsertEnter",
    config = function()
      require("boole").setup({
        mappings = {
          increment = '+',
          decrement = '-'
        },
        additions = {
          { "const",    "let",      "var" },
          { "absolute", "relative", "fixed", "sticky" }
        }
      })
    end,
  },
  {
    "gaoDean/autolist.nvim",
    event = "InsertEnter",
    config = true,
  },
  -------------------------
  -- Syntax Highlighting --
  -------------------------
  {
    "norcalli/nvim-colorizer.lua",
    config = true,
    event = "BufReadPost",
  },
  {
    "folke/todo-comments.nvim",
    config = true,
    event = "VeryLazy",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "windwp/nvim-ts-autotag",
    },
    config = function()
      require("max.configs.treesitter")
    end,
    build = ":TSUpdate",
  },
  --------------------
  -- IDE Type Stuff --
  --------------------
  {
    "rest-nvim/rest.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("rest-nvim").setup({})
    end,
  },
  {
    "chrisgrieser/nvim-recorder",
    event = "VeryLazy",
    config = function()
      require("recorder").setup({
        logLevel = vim.log.levels.OFF,
      })
    end,
  },
  {
    "jackMort/ChatGPT.nvim",
    cmd = "ChatGPT",
    config = true,
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
  },
  {
    "olimorris/persisted.nvim",
    lazy = false,
    config = function()
      require("max.configs.session")
    end,
  },
  --Dap Debugger -- Have not yet been able to set this up
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "mxsdev/nvim-dap-vscode-js",
    },
    config = function()
      require("max.configs.dap")
    end,
  },
  {
    "michaelb/sniprun",
    event = "BufRead",
    config = function()
      require("max.configs.sniprun")
    end,
    build = "bash ./install.sh",
  },
  {
    "uga-rosa/translate.nvim",
    event = "InsertEnter",
    config = function()
      require("translate").setup({ default = { output = "replace" } })
    end,
  },
  {
    "nvim-neotest/neotest",
    cmd = "NeoTest",
    config = function()
      require("max.configs.neotest")
    end,
    dependencies = {
      "haydenmeade/neotest-jest",
      "KaiSpencer/neotest-vitest",
      "antoinemadec/FixCursorHold.nvim",
    },
  },
  {
    "tpope/vim-dadbod",
    dependencies = {
      "kristijanhusak/vim-dadbod-completion",
      "kristijanhusak/vim-dadbod-ui",
    },
    cmd = "DBUI"
  },
}

local opts = {
  defaults = { lazy = true },
  install = { colorscheme = { require("max.theme").name } },
  change_detection = {
    enabled = true, -- automatically check for config file changes and reload the ui
    notify = true,  -- get a notification when changes are found
  },
  performance = {
    rtp = {
      reset = true,
      disabled_plugins = {
        "gzip",
        "zip",
        "zipPlugin",
        "fzf",
        "tar",
        "tarPlugin",
        "getscript",
        "getscriptPlugin",
        "vimball",
        "vimballPlugin",
        "2html_plugin",
        "matchit",
        "matchparen",
        "logiPat",
        "rrhelper",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
      },
    },
  }
}

require("lazy").setup(plugins, opts)
