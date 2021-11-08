return require("packer").startup(function()

	-- Let packer manage itself
	use "wbthomason/packer.nvim"

	-- General Helper Functions
	use "nvim-lua/plenary.nvim"
	
	use "alexghergh/nvim-tmux-navigation"

	-- Theming Section
	use "kaicataldo/material.vim"
	use "xiyaowong/nvim-transparent"

	-- Layout Plugins
	use "kyazdani42/nvim-web-devicons"
	use "kyazdani42/nvim-tree.lua"
	use "nvim-lua/popup.nvim"
	use "mhinz/vim-startify"
	use "lukas-reineke/indent-blankline.nvim"
	
	-- Code Navigation
	use "dense-analysis/ale"
	use "nathanmsmith/nvim-ale-diagnostic"
	use "junegunn/fzf"
	use "nvim-telescope/telescope.nvim"

	-- Postman like features
	use "NTBBloodbath/rest.nvim"

	-- Obsidian / Roam like features
	-- use "lervag/wiki.vim"

	-- Syntax / Autocomplete
	use "preservim/nerdcommenter"
	use "neovim/nvim-lspconfig"
	use "williamboman/nvim-lsp-installer"
	use "nvim-lua/lsp-status.nvim"
	use "hrsh7th/nvim-cmp"
	use "hrsh7th/cmp-nvim-lsp"
	use "weilbith/nvim-code-action-menu" -- Need to find better alternative
	use "L3MON4D3/LuaSnip"
	use "windwp/nvim-autopairs"
	use "neoclide/jsonc.vim"
	use {
        	'nvim-treesitter/nvim-treesitter',
        	run = ':TSUpdate'
	}


	use "sbdchd/neoformat"

	-- General Popup Window
	use "akinsho/nvim-toggleterm.lua"

	-- Database Feature
	use "tpope/vim-dadbod"
	use "kristijanhusak/vim-dadbod-ui"

end)
