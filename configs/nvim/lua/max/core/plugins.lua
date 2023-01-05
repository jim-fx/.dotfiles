local plugins = {

  "nvim-lua/plenary.nvim",

  ---------------------
  -- Theming Section --
  ---------------------

  "rktjmp/fwatch.nvim", -- d to check dark/light theme
  { "catppuccin/nvim", name = "catppuccin", priority = 1000, lazy = false },

  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("max.configs.lualine")
    end,
  },

  --------------------
  -- Layout Plugins --
  --------------------

  {
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function()
      require("which-key").setup({})
    end,
  },
  {
    "ldelossa/litee.nvim",
    command = "InsertEnter",
    dependencies = {
      "ldelossa/litee-symboltree.nvim",
      "ldelossa/litee-calltree.nvim",
    },
    config = function()
      require("max.configs.litee")
    end,
  },
  { "ethanholz/nvim-lastplace", event = "BufReadPre", config = true },
  { "mbbill/undotree", lazy = false },
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("max.configs.scrollbar")
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
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
    "kyazdani42/nvim-tree.lua",
    event = "VimEnter",
    -- lazy = false,
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("max.configs.tree")
    end,
  },
  "nvim-lua/popup.nvim",
  {
    "goolord/alpha-nvim",
    config = function()
      require("max.configs.dashboard")
    end,
  }, -- startup screen
  {
    "numToStr/Comment.nvim",
    event = "BufReadPre",
    config = function()
      require("Comment").setup()
    end,
  },
  ---------------------
  -- Code Navigation --
  ---------------------
  "junegunn/fzf",
  {
    "ggandor/leap.nvim",

    config = function()
      local leap = require("leap")
      leap.add_default_mappings()
      leap.setup({})
    end,
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

  { "glepnir/lspsaga.nvim",
    command = "Lspsaga"
  }, -- better windows for lsp replace, goto definition etc...
  { "VonHeikemen/lsp-zero.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "arkav/lualine-lsp-progress",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "L3MON4D3/LuaSnip",
      "onsails/lspkind.nvim",
      "rafamadriz/friendly-snippets",
      { "lukas-reineke/lsp-format.nvim", config = true },
    },
    lazy = false,
    config = function()
      local lsp = require("lsp-zero")
      lsp.preset("recommended")
      lsp.on_attach(function(client, bufnr)
        require("lsp-format").on_attach(client, bufnr)
      end)
      lsp.nvim_workspace()
      lsp.setup()
      vim.diagnostic.config { virtual_text = true }

    end },
  {
    "folke/trouble.nvim",
    command = "TroubleToggle",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup({})
    end,
  },
  {
    url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    event = "BufReadPre",
    config = true
  },
  -------------------
  --  Autocomplete --
  -------------------
  { "tpope/vim-surround", event = "InsertEnter" },
  {
    "nat-418/boole.nvim",
    event = "BufReadPre",
    config = function()
      require("boole").setup()
    end,
  },
  {
    "gaoDean/autolist.nvim",
    event = "BufReadPre",
    config = function()
      require("autolist").setup({})
    end,
  },
  -------------------------
  -- Syntax Highlighting --
  -------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPost",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("max.configs.treesitter")
    end,
    run = ":TSUpdate",
  },
  --------------------
  -- IDE Type Stuff --
  --------------------
  {
    "jackMort/ChatGPT.nvim",
    command = "ChatGPT",
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
    command = "SnipRun",
    config = function()
      require("max.configs.sniprun")
    end,
    run = "bash ./install.sh",
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
