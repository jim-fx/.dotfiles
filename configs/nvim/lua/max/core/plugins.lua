local plugins = {

  "nvim-lua/plenary.nvim",

  ---------------------
  -- Theming Section --
  ---------------------

  "rktjmp/fwatch.nvim", -- d to check dark/light theme
  { "catppuccin/nvim", name = "catppuccin", priority = 1000, lazy = false },
  -- local plugins need to be explicitly configured with dir
  {
    dir = "~/Projects/sudoku.nvim",
    cmd = "Sudoku",
    config = true,
  },
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    config = function()
      require("max.configs.lualine")
    end,
  },

  --------------------
  -- Layout Plugins --
  --------------------
  { "shortcuts/no-neck-pain.nvim", cmd = "NoNeckPain", config = true },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function()
      require("which-key").setup({})
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    config = true,
  },
  { "mbbill/undotree", event = "VeryLazy" },
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("max.configs.scrollbar")
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    config = function()
      require("gitsigns").setup()
    end,
  },
  "akinsho/nvim-toggleterm.lua",
  {
    "akinsho/git-conflict.nvim",
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
    "folke/neodev.nvim",
    lazy = false,
    config = true,
  },
  {
    "kevinhwang91/nvim-ufo",
    event = "BufReadPost",
    dependencies = "kevinhwang91/promise-async",
    config = require("max.configs.ufo"),
  },
  {
    "kyazdani42/nvim-tree.lua",
    event = "VeryLazy",
    -- lazy = false,
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("max.configs.tree")
    end,
  },
  "nvim-lua/popup.nvim",
  {
    "goolord/alpha-nvim",
    lazy = false,
    config = function()
      require("max.configs.dashboard")
    end,
  }, -- startup screen
  {
    "notomo/gesture.nvim",
    lazy = false,
    config = function()
      require("max.configs.gestures")
    end,
  },
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
  "junegunn/fzf",
  {
    "ggandor/flit.nvim",
    dependencies = {
      "ggandor/leap.nvim",
    },
    event = "VimEnter",
    config = true,
  },
  {
    "nvim-telescope/telescope.nvim",
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
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup({})
    end,
  },
  -------------------
  --  Autocomplete --
  -------------------
  { "tpope/vim-surround", lazy = false },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "windwp/nvim-autopairs",
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
      require("boole").setup()
    end,
  },
  {
    "gaoDean/autolist.nvim",
    event = "InsertEnter",
    config = function()
      require("autolist").setup({})
    end,
  },
  -------------------------
  -- Syntax Highlighting --
  -------------------------
  {
    "norcalli/nvim-colorizer.lua",
    config = true,
    event = "VeryLazy",
  },
  {
    "folke/todo-comments.nvim",
    config = true,
    event = "VeryLazy",
  },
  {
    "styled-components/vim-styled-components",
    lazy = false,
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
  {
    "ckolkey/ts-node-action",
    dependencies = { "nvim-treesitter" },
    opts = {},
  },
  --------------------
  -- IDE Type Stuff --
  --------------------
  {
    "ThePrimeagen/git-worktree.nvim",
    config = true,
    event = "VeryLazy"
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
  "editorconfig/editorconfig-vim",
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
    lazy = false,
  },
  { "kristijanhusak/vim-dadbod-ui", lazy = false },
}

local opts = { defaults = { lazy = true }, install = { colorscheme = { "catppuccin" } } }

require("lazy").setup(plugins, opts)
