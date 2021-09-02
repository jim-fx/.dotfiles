local u = require("utils")

local o = vim.o
local opt = vim.opt
local g = vim.g
local cmd = vim.cmd;

require("install-paq")

local paq = require("paq");
paq:setup({verbose=true}) {
  "savq/paq-nvim", -- Let Paq manage itself
  -- Theming Plugins
  "kaicataldo/material.vim",
  "ryanoasis/vim-devicons",
  "junegunn/fzf",
  "xiyaowong/nvim-transparent",
  -- Layout Plugins
  "preservim/nerdtree",
	"preservim/nerdtree",
  "jistr/vim-nerdtree-tabs",
  -- Code Navigation
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim",
  -- Syntax / Autocomplete
  "neovim/nvim-lspconfig",
  "nvim-lua/lsp-status.nvim",
  "hrsh7th/nvim-compe",
  {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"},
  -- Formatting
  "mhartington/formatter.nvim",
  -- Git Interface
  "akinsho/nvim-toggleterm.lua"
}

if u.has_plugin("material") then

  print("Load config")

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
  g.NERDTreeShowHidden = true
  g.NERDTreeAutoDeleteBuffer = true
  g.NERDTreeMinimalUI = true
  g.NERDTreeDirArrows = true
	g.NERDTreeCustomOpenArgs={file = {where = 't'}}
	g.hidden = true
  g.material_style = "deep ocean"
  require("transparent").setup({enable = true})
  -- Remove background color
  cmd("highlight Normal guibg=none")
  cmd("highlight NonText guibg=none")

  -- KeyBindings
  g.mapleader = " "
  require "keymappings"

  -- Treesitter config
  require "nvim-treesitter.configs".setup {ensure_installed = {"bash", "svelte", "css", "svelte", "typescript", "javascript", "go", "lua", "yaml"}, highlight = {enable = true}}
  -- Toggleterm / Lazygit setup
  require "lazy-git"
  -- Autocommands
  u.create_augroup(
    {
      {"VimEnter", "*", "if (@% == '') | NERDTree | endif"},
      {"BufEnter", "*", 'if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif'}
    },
    "Nerdtree"
  )

  -- Autocompletion Setup
  require "autocomplete"

  -- LSP Config

  require "lsp-utils"

  opt.completeopt = {"menuone", "noinsert", "noselect"}
  opt.shortmess:append({c = true})

  -- Autoformat
  require "autoformatter"


else
  paq.install();
end
