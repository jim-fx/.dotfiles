local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap = false
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
  vim.cmd 'packadd packer.nvim'
end

local packer = require("packer")
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  }
}

return packer.startup(function(use)
  -- Let packer manage itself
  use "wbthomason/packer.nvim"
  use 'lewis6991/impatient.nvim'

  -- General Helper Functions
  use "nvim-lua/plenary.nvim"

  -- Theming Section
  use "rktjmp/fwatch.nvim" -- Used to check dark/light theme
  use "EdenEast/nightfox.nvim"
  use "nvim-lualine/lualine.nvim"

  -- Layout Plugins
  use "dstein64/nvim-scrollview" -- ScrollBars
  use "akinsho/nvim-toggleterm.lua"
  use { "folke/zen-mode.nvim", config = function() require("zen-mode").setup {} end }
  use "rcarriga/nvim-notify"
  use "kyazdani42/nvim-web-devicons"
  use "kyazdani42/nvim-tree.lua"
  use "nvim-lua/popup.nvim"
  use 'goolord/alpha-nvim'
  use { "terrortylor/nvim-comment", config = function() require('nvim_comment').setup() end }
  use { "windwp/nvim-autopairs", config = function() require('nvim-autopairs').setup() end }
  use "gfeiyou/command-center.nvim"

  -- Code Navigation
  use "junegunn/fzf"
  use "nvim-telescope/telescope.nvim"

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
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-calc"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-cmdline"
  use "rafamadriz/friendly-snippets"
  use "L3MON4D3/LuaSnip"
  use "saadparwaiz1/cmp_luasnip"
  use "williamboman/nvim-lsp-installer"
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }

  -- More IDE like features
  use {
    'rmagatti/session-lens',
    requires = { 'rmagatti/auto-session', 'nvim-telescope/telescope.nvim' },
    config = function()
      require('session-lens').setup({ path_display = { 'shorten' } })
    end
  }
  use { "rcarriga/vim-ultest", requires = { "vim-test/vim-test" }, run = ":UpdateRemotePlugins" }

  -- Database Feature
  use "tpope/vim-dadbod"
  use "kristijanhusak/vim-dadbod-ui"

  if packer_bootstrap then
    packer.sync()
  end

end)
