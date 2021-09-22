local u = require("utils")

local o = vim.o
local g = vim.g
local cmd = vim.cmd

require("install-paq")

local paq = require("paq")
paq:setup({verbose = true}) {
  "savq/paq-nvim", -- Let Paq manage itself
  -- General Helper Function
  "nvim-lua/plenary.nvim",
  -- Theming Plugins
  "kaicataldo/material.vim",
  "xiyaowong/nvim-transparent",
  -- Layout Plugins
  --"preservim/nerdtree",
  --"unkiwii/vim-nerdtree-sync",
  "kyazdani42/nvim-web-devicons",
  "kyazdani42/nvim-tree.lua",
  "karb94/neoscroll.nvim",
  -- Code Navigation
  "junegunn/fzf",
  "nvim-lua/popup.nvim",
  "nvim-telescope/telescope.nvim",
  -- Postman like featuresi
  "NTBBloodbath/rest.nvim",
  -- Obsidian / Roam features
  "lervag/wiki.vim",
  -- Syntax / Autocomplete
  "preservim/nerdcommenter",
  "neovim/nvim-lspconfig",
  "kabouzeid/nvim-lspinstall",
  "nvim-lua/lsp-status.nvim",
  "hrsh7th/nvim-cmp", -- Autocompletion plugin
  "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
  --"saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
  "L3MON4D3/LuaSnip", -- Snippets plugin
  {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"},
  -- Formatting
  "mhartington/formatter.nvim",
  -- Git Interface
  "akinsho/nvim-toggleterm.lua",
  -- Database Interface
  "tpope/vim-dadbod",
  "kristijanhusak/vim-dadbod-ui"
}

if u.has_plugin("cmp") then
  -- Global options
  o.number = true
  o.tabstop = 2
  o.shiftwidth = 2 -- Indents will have a width of 4
  o.softtabstop = 2 -- Sets the number of columns for a TAB
  o.expandtab = false -- Expand TABs to spaces
  cmd [[set mouse=a]]
  cmd [[set undofile]]

  -- Apply Theme
  o.syntax = "enable"
  o.termguicolors = true
  --g.NERDTreeShowHidden = true
  --g.NERDTreeAutoDeleteBuffer = true
  --g.NERDTreeMinimalUI = true
  --g.NERDTreeDirArrows = true
  -- g.NERDTreeCustomOpenArgs = {file = {where = "t"}}

  g.nvim_tree_auto_open = 1
  g.hidden = true
  g.filetype = true
  g.material_terminal_italics = 1
  g.material_theme_style = "darker"
  g.wiki_root = "~/Notes"
  g.wiki_filetypes = {"md"}
  g.wiki_link_extension = ".md"
  cmd("colorscheme material")
  -- Remove background color
  require("transparent").setup({enable = true})
  cmd("highlight Normal guibg=none")
  cmd("highlight NonText guibg=none")

  -- KeyBindings
  g.mapleader = " "
  require "keymappings"

  -- Treesitter config
  local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
  parser_configs.http = {
    install_info = {
      url = "https://github.com/NTBBloodbath/tree-sitter-http",
      files = {"src/parser.c"},
      branch = "main"
    }
  }
  require "nvim-treesitter.configs".setup {
    ensure_installed = {
      "bash",
      "yaml",
      "http",
      "svelte",
      "css",
      "svelte",
      "typescript",
      "javascript",
      "go",
      "lua",
      "yaml"
    },
    highlight = {enable = true}
  }
  -- Toggleterm / Lazygit setup
  require "lazy-git"

  require("nvim-tree.view").View.winopts.signcolumn = "no"

  -- Autocommands
  --[[ u.create_augroup(]]
  --[[{]]
  --[[{"StdinReadPre", "*", "let s:std_in=1"},]]
  --[[{"VimEnter", "*", "if argc() == 0 && !exists('s:std_in') | NERDTree | endif"},]]
  --[[{"BufEnter", "*", 'if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif'},]]
  --[[{"BufWinEnter", "*", "if getcmdwintype() == '' | silent NERDTreeMirror | endif"}]]
  --[[},]]
  --[["Nerdtree"]]
  --[[)]]
  -- Setup rest.vim
  require("rest-nvim").setup(
    {
      -- Open request results in a horizontal split
      result_split_horizontal = false,
      -- Skip SSL verification, useful for unknown certificates
      skip_ssl_verification = false,
      -- Highlight request on run
      highlight = {
        enabled = true,
        timeout = 150
      },
      -- Jump to request line on run
      jump_to_request = false
    }
  )

  -- Smooth Scrolling
  require("neoscroll").setup()

  -- Autocompletion Setup
  o.completeopt = "menuone,noselect"
  require "autocomplete"

  -- LSP Config
  require "lspinstall".setup()
  require "lsp-utils"

  -- Autoformat
  require "autoformatter"
else
  paq.install()
end
