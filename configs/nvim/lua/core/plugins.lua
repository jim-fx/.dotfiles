return require("packer").startup(
  function(use)
  -- Let packer manage itself
  use "wbthomason/packer.nvim"
  use 'lewis6991/impatient.nvim'

  -- General Helper Functions
  use "nvim-lua/plenary.nvim"

  -- Theming Section
  use "EdenEast/nightfox.nvim"
  use "nvim-lualine/lualine.nvim"

  -- Layout Plugins
  use { "folke/zen-mode.nvim", config = function() require("zen-mode").setup {} end }
  use "rcarriga/nvim-notify"
  use "kyazdani42/nvim-web-devicons"
  use "kyazdani42/nvim-tree.lua"
  use "nvim-lua/popup.nvim"
  use 'goolord/alpha-nvim'
  use { "terrortylor/nvim-comment", config = function() require('nvim_comment').setup() end }
  use "windwp/nvim-autopairs"

  -- Code Navigation
  use "junegunn/fzf"
  use "nvim-telescope/telescope.nvim"
  use "gfeiyou/command-center.nvim"


  -- Lsp Errors
  use "folke/lsp-colors.nvim"
  use "kosayoda/nvim-lightbulb"
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end
  }

  -- Syntax / Autocomplete
  use "tpope/vim-surround"
  use "neovim/nvim-lspconfig"
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-calc"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-cmdline"
  use "rafamadriz/friendly-snippets"
  use "L3MON4D3/LuaSnip"
  use "saadparwaiz1/cmp_luasnip"
  use "williamboman/nvim-lsp-installer"
  use "brymer-meneses/grammar-guard.nvim"
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  }

  -- Autoformat
  use "lukas-reineke/lsp-format.nvim"

  -- General Popup Window
  use "akinsho/nvim-toggleterm.lua"

  use "rktjmp/fwatch.nvim"

  -- Database Feature
  use "tpope/vim-dadbod"
  use "kristijanhusak/vim-dadbod-ui"
end
)
