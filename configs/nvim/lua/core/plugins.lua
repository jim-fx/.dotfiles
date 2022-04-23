return require("packer").startup(
    function(use)
        -- Let packer manage itself
        use "wbthomason/packer.nvim"

        use 'lewis6991/impatient.nvim'

        -- General Helper Functions
        use "nvim-lua/plenary.nvim"

        -- Filetype Detection
        -- use "nathom/filetype.nvim"

        -- Theming Section
        -- use 'folke/tokyonight.nvim'
        use "EdenEast/nightfox.nvim"
        use "nvim-lualine/lualine.nvim"
        -- use "xiyaowong/nvim-transparent"

        -- Layout Plugins
        use "kyazdani42/nvim-web-devicons"
        use "kyazdani42/nvim-tree.lua"
        use "nvim-lua/popup.nvim"
        use "mhinz/vim-startify"
        -- use "tpope/vim-fugitive"
        use "tpope/vim-commentary"
        -- use "tpope/vim-surround"
        -- use "lambdalisue/suda.vim"
        use "windwp/nvim-autopairs"

        -- Code Navigation
        -- use "alexghergh/nvim-tmux-navigation"
        -- use "dense-analysis/ale"
        -- use "nathanmsmith/nvim-ale-diagnostic"
        use "junegunn/fzf"
        use "nvim-telescope/telescope.nvim"
        use "gfeiyou/command-center.nvim"

        -- Postman like features
        -- use "NTBBloodbath/rest.nvim"

        -- Obsidian / Roam like features
        -- use "lervag/wiki.vim"

        use "rcarriga/nvim-notify"

        -- Lsp Errors
        use "folke/lsp-colors.nvim"
        use "kosayoda/nvim-lightbulb"
        -- use "onsails/lspkind-nvim"
        use {
            "folke/trouble.nvim",
            requires = "kyazdani42/nvim-web-devicons",
            config = function()
                require("trouble").setup {}
            end
        }

        -- Syntax / Autocomplete
        -- use "terminalnode/sway-vim-syntax" --sway config syntax
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
        use "nvim-lua/lsp-status.nvim"
        -- use "jose-elias-alvarez/nvim-lsp-ts-utils"
        -- use "neoclide/jsonc.vim"
        use "brymer-meneses/grammar-guard.nvim"
        use {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate"
        }

        -- Autoformat
        -- use "sbdchd/neoformat"
        use "lukas-reineke/lsp-format.nvim"
        -- use "lukas-reineke/format.nvim"

        -- General Popup Window
        use "akinsho/nvim-toggleterm.lua"

        use "rktjmp/fwatch.nvim"

        -- Database Feature
        use "tpope/vim-dadbod"
        use "kristijanhusak/vim-dadbod-ui"
    end
)
