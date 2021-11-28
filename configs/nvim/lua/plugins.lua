return require("packer").startup(function()

	-- Let packer manage itself
	use "wbthomason/packer.nvim"

	-- General Helper Functions
	use "nvim-lua/plenary.nvim"

  -- Faster Filetype Detection
  use "nathom/filetype.nvim"
	use "alexghergh/nvim-tmux-navigation"

  use 'lervag/vimtex'

	-- Theming Section
  use 'folke/tokyonight.nvim'
	use "xiyaowong/nvim-transparent"

	-- Layout Plugins
	use "kyazdani42/nvim-web-devicons"
	use "kyazdani42/nvim-tree.lua"
	use "nvim-lua/popup.nvim"
	use "mhinz/vim-startify"
	use "karb94/neoscroll.nvim"

	use "tpope/vim-fugitive"
  use "tpope/vim-surround"
  use "lambdalisue/suda.vim"
  use "editorconfig/editorconfig-vim"

	-- Code Navigation
	use "dense-analysis/ale"
	use "nathanmsmith/nvim-ale-diagnostic"
	use "junegunn/fzf"
	use "nvim-telescope/telescope.nvim"

	-- Postman like features
	use "NTBBloodbath/rest.nvim"

	-- Obsidian / Roam like features
	-- use "lervag/wiki.vim"

  -- Lsp Errors
  use "folke/lsp-colors.nvim"
  use "onsails/lspkind-nvim"
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

	-- Syntax / Autocomplete
  use "terminalnode/sway-vim-syntax"
  use "neovim/nvim-lspconfig"
  use "github/copilot.vim"
  use "hrsh7th/nvim-cmp"
	use "hrsh7th/cmp-nvim-lsp"
	use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-calc"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-cmdline"
  use "L3MON4D3/LuaSnip"
  use "saadparwaiz1/cmp_luasnip"
  use "rafamadriz/friendly-snippets"

  use "beyondmarc/glsl.vim"

  use "tpope/vim-commentary"

	use "williamboman/nvim-lsp-installer"
	use "nvim-lua/lsp-status.nvim"
	use "windwp/nvim-autopairs"
	use "neoclide/jsonc.vim"
	use {
					'nvim-treesitter/nvim-treesitter',
					run = ':TSUpdate'
	}

	-- Preview Markdown
	use "ellisonleao/glow.nvim"

  -- Autoformat
	--use "sbdchd/neoformat"
	-- use "lukas-reineke/format.nvim"

	-- General Popup Window
	use "akinsho/nvim-toggleterm.lua"

	-- Database Feature
	use "tpope/vim-dadbod"
	use "kristijanhusak/vim-dadbod-ui"

end)
