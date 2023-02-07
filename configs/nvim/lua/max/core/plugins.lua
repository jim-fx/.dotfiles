local plugins = {

  {
    dir = "~/Projects/sudoku.nvim",
    cmd = "Sudoku",
    config = true
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
  { "shortcuts/no-neck-pain.nvim", cmd = "NoNeckPain", config = true },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true
      },
    },
    keys = {
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
    },
  },
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
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
    "akinsho/git-conflict.nvim",
    version = "*",
    dependencies = {
      "akinsho/nvim-toggleterm.lua",
    },
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
    "kevinhwang91/nvim-ufo",
    event = "BufReadPost",
    dependencies = "kevinhwang91/promise-async",
    config = require("max.configs.ufo"),
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim"
    },
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      require("neo-tree").setup({
        hide_root_node = true,
        highlight_background = "Normal",
      })
    end,
  },
  {
    "goolord/alpha-nvim",
    lazy = false,
    config = function()
      require("max.configs.dashboard")
    end,
  }, -- startup screen
  {
    "numToStr/Comment.nvim",
    event = "InsertEnter",
    config = function()
      require("Comment").setup()
    end,
  },
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
    event = "InsertEnter",
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
          increment = '-',
          decrement = '+'
        },
        additions = {
          { "const", "let", "var" }
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
  -- Dap Debugger -- Have not yet been able to set this up
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

local opts = { defaults = { lazy = true }, install = { colorscheme = { require("max.theme").name } } }

require("lazy").setup(plugins, opts)
