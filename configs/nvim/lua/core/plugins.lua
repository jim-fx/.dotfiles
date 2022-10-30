local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap = false
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = true
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

  -- General Helper Functions
  use("lewis6991/impatient.nvim")
  use("nvim-lua/plenary.nvim")

  ---------------------
  -- Theming Section --
  ---------------------

  use("rktjmp/fwatch.nvim") -- Used to check dark/light theme
  use({ "catppuccin/nvim", as = "catppuccin" })
  use("nvim-lualine/lualine.nvim")

  --------------------
  -- Layout Plugins --
  --------------------

  use("dstein64/nvim-scrollview") -- ScrollBars
  use("akinsho/nvim-toggleterm.lua")

  use({
    "rcarriga/nvim-notify",
    config = function()
      require("configs.notify")
    end,
    event = "VimEnter",
  })

  use({
    "kyazdani42/nvim-tree.lua",
    requires = { "kyazdani42/nvim-web-devicons" },
    cmd = "NvimTreeToggle",
    config = function()
      require("configs.tree")
    end,
  })
  use("nvim-lua/popup.nvim")
  use("goolord/alpha-nvim") -- startup screen
  -- use("Pocco81/true-zen.nvim")
  use({
    "numToStr/Comment.nvim",
    event = "BufReadPre",
    config = function()
      require("Comment").setup()
    end,
  })
  -- use("gfeiyou/command-center.nvim")
  use("glepnir/lspsaga.nvim") -- better windows for lsp replace, goto definition etc...

  ---------------------
  -- Code Navigation --
  ---------------------

  use("junegunn/fzf")
  use({ "ggandor/leap.nvim",
    config = function()
      local leap = require("leap")
      leap.add_default_mappings()
      leap.setup({})
    end })
  use({
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    config = function()
      require("configs.telescope")
    end,
  })
  use("ThePrimeagen/harpoon")

  ---------------
  -- Lsp Setup --
  ---------------

  use("neovim/nvim-lspconfig")
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")
  use("jose-elias-alvarez/null-ls.nvim")
  use("folke/lsp-colors.nvim")
  -- use("kosayoda/nvim-lightbulb")
  use({
    "folke/trouble.nvim",
    event = "BufRead",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup({})
    end,
  })
  use("onsails/lspkind.nvim")
  use({
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    event = "BufReadPre",
    config = function()
      require("lsp_lines").setup()
    end,
  })

  -------------------
  --  Autocomplete --
  -------------------

  use("tpope/vim-surround")
  use({
    "hrsh7th/nvim-cmp",
    requires = {

      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "windwp/nvim-autopairs",

      "zbirenbaum/copilot.lua",
      "zbirenbaum/copilot-cmp",
    },
    event = { "BufReadPre", "CmdlineChanged" },
    config = function()
      require("configs.autocomplete")
      require("configs.snippets")
    end,
  })

  use({
    "hrsh7th/cmp-nvim-lsp",
    after = "nvim-cmp",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      require("lspconfig").html.setup({
        capabilities = capabilities,
      })
    end,
  })
  use({ "hrsh7th/cmp-cmdline", after = "nvim-cmp" })
  use({ "hrsh7th/cmp-path", after = "nvim-cmp" })
  use({ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" })
  use({ "hrsh7th/cmp-calc", after = "nvim-cmp" })
  use({ "hrsh7th/cmp-emoji", after = "nvim-cmp" })

  use({
    "https://github.com/nat-418/boole.nvim",
    event = "BufReadPre",
    config = function()
      require("boole").setup()
    end,
  })
  use({
    "gaoDean/autolist.nvim",
    event = "BufReadPre",
    config = function()
      require("autolist").setup({})
    end,
  })

  -------------------------
  -- Syntax Highlighting --
  -------------------------

  use({
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPost",
    requires = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("configs.treesitter")
    end,
    run = ":TSUpdate",
  })

  --------------------
  -- IDE Type Stuff --
  --------------------
  use("ThePrimeagen/vim-be-good")

  -- Dap Debugger -- Have not yet been able to set this up
  -- use({ "mfussenegger/nvim-dap" })
  -- use({ "rcarriga/nvim-dap-ui" free
  use("editorconfig/editorconfig-vim")
  use({
    "michaelb/sniprun",
    event = "BufReadPost",
    config = function()
      require("configs.sniprun")
    end,
    run = "bash ./install.sh",
  })
  use({
    "uga-rosa/translate.nvim",
    event = "InsertEnter",
    config = function()
      require("translate").setup({ default = { output = "replace" } })
    end,
  })
  use({
    "nvim-neotest/neotest",
    cmd = "NeoTest",
    config = function()
      require("configs.neotest")
    end,
    requires = {
      "haydenmeade/neotest-jest",
      "KaiSpencer/neotest-vitest",
      "antoinemadec/FixCursorHold.nvim",
    },
  })

  use("tpope/vim-dadbod")
  use("kristijanhusak/vim-dadbod-ui")

  if packer_bootstrap then
    packer.sync()
  end
end)
