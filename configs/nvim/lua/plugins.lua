return require("packer").startup(
    function()
        -- Let packer manage itself
        use "wbthomason/packer.nvim"

        -- General Helper Functions
        use "nvim-lua/plenary.nvim"

        -- Faster Filetype Detection
        use "nathom/filetype.nvim"
        use "alexghergh/nvim-tmux-navigation"

        -- Theming Section
        -- use 'folke/tokyonight.nvim'
        use "EdenEast/nightfox.nvim"
        use "xiyaowong/nvim-transparent"

        -- Layout Plugins
        use "kyazdani42/nvim-web-devicons"
        use "kyazdani42/nvim-tree.lua"
        use "nvim-lua/popup.nvim"
        use "mhinz/vim-startify"
        use "tpope/vim-fugitive"
        use "tpope/vim-commentary"
        use "tpope/vim-surround"
        use "lambdalisue/suda.vim"
        use "windwp/nvim-autopairs"

        -- Code Navigation
        use "dense-analysis/ale"
        use "nathanmsmith/nvim-ale-diagnostic"
        use "junegunn/fzf"
        use "nvim-telescope/telescope.nvim"

        use "sakhnik/nvim-gdb"

        -- Postman like features
        use "NTBBloodbath/rest.nvim"

        -- Obsidian / Roam like features
        -- use "lervag/wiki.vim"

        use "rcarriga/nvim-notify"

        -- Lsp Errors
        use "folke/lsp-colors.nvim"
        use "onsails/lspkind-nvim"
        use {
            "folke/trouble.nvim",
            requires = "kyazdani42/nvim-web-devicons",
            config = function()
                require("trouble").setup()
            end
        }

        -- Syntax / Autocomplete
        use "neovim/nvim-lspconfig"
        use "hrsh7th/nvim-cmp"
        use "hrsh7th/cmp-nvim-lsp"
        use "hrsh7th/cmp-nvim-lua"
        use "hrsh7th/cmp-path"
        use "hrsh7th/cmp-calc"
        use "hrsh7th/cmp-buffer"
        use "hrsh7th/cmp-cmdline"
        use "L3MON4D3/LuaSnip"
        use "saadparwaiz1/cmp_luasnip"
        use "rafamadriz/friendly-snippets"
        use "williamboman/nvim-lsp-installer"
        use "nvim-lua/lsp-status.nvim"
        use "neoclide/jsonc.vim"
        use {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate"
        }

        -- Language Supports
        use "beyondmarc/glsl.vim" -- GLSL
        use "ellisonleao/glow.nvim" -- MARKDOWN

        -- Autoformat
        use "sbdchd/neoformat"
        -- use "lukas-reineke/format.nvim"

        -- General Popup Window
        use "akinsho/nvim-toggleterm.lua"

        -- Database Feature
        use "tpope/vim-dadbod"
        use "kristijanhusak/vim-dadbod-ui"
    end
)
