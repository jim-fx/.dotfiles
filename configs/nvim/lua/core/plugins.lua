local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap = false
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap =
  fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
  vim.cmd("packadd packer.nvim")
end

local packer = require("packer")
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

return packer.startup(function(use)
  -- Let packer manage itself
  use("wbthomason/packer.nvim")
  use("lewis6991/impatient.nvim")

  -- General Helper Functions
  use("nvim-lua/plenary.nvim")

  -- Theming Section
  use("rktjmp/fwatch.nvim") -- Used to check dark/light theme
  -- use("EdenEast/nightfox.nvim")
  use({ "catppuccin/nvim", as = "catppuccin" })
  use("nvim-lualine/lualine.nvim")
  -- use("sam4llis/nvim-tundra")

  -- Layout Plugins
  use("dstein64/nvim-scrollview") -- ScrollBars
  use("akinsho/nvim-toggleterm.lua")
  use("rcarriga/nvim-notify")
  use("kyazdani42/nvim-web-devicons")
  use("kyazdani42/nvim-tree.lua")
  use("nvim-lua/popup.nvim")
  use("goolord/alpha-nvim") -- startup screen
  use("Pocco81/true-zen.nvim")
  use({
    "terrortylor/nvim-comment",
    config = function()
      require("nvim_comment").setup()
    end,
  })
  use("gfeiyou/command-center.nvim")
  use("glepnir/lspsaga.nvim")

  -- Code Navigation
  use("junegunn/fzf")
  use("nvim-telescope/telescope.nvim")

  -- Lsp Errors
  use("folke/lsp-colors.nvim")
  use("kosayoda/nvim-lightbulb")
  use({
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup({})
    end,
  })
  use("onsails/lspkind.nvim")
  use({
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end,
  })

  -- Syntax / Autocomplete
  use("tpope/vim-surround")
  use("neovim/nvim-lspconfig")
  use("hrsh7th/nvim-cmp")
  use({
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  })
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-path")
  -- use("hrsh7th/cmp-calc")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-cmdline")
  use("rafamadriz/friendly-snippets")
  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")

  use({ "williamboman/mason.nvim" })
  use({ "williamboman/mason-lspconfig.nvim" })
  use({ "jose-elias-alvarez/null-ls.nvim" })
  use("MunifTanjim/prettier.nvim")
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

  -- Dap Debugger -- Have not yet been able to set this up
  -- use({ "mfussenegger/nvim-dap" })
  -- use({ "rcarriga/nvim-dap-ui" })
  use { 'michaelb/sniprun', run = 'bash ./install.sh' }

  -- FIle Navigation
  use({ "ThePrimeagen/harpoon" })

  -- More IDE like features
  use("editorconfig/editorconfig-vim")
  use({
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
  })
  use({
    "nvim-neotest/neotest",
    requires = {
      "haydenmeade/neotest-jest",
      "KaiSpencer/neotest-vitest",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
    },
  })

  -- Database Feature
  use("tpope/vim-dadbod")
  use("kristijanhusak/vim-dadbod-ui")

  if packer_bootstrap then
    packer.sync()
  end
end)
