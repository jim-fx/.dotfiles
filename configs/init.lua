local u = require("utils")

local o = vim.o
local opt = vim.opt
local wo = vim.wo
local bo = vim.bo
local g = vim.g
local fn = vim.fn

-- Global options
o.number = true
o.tabstop = 2
o.shiftwidth = 2 -- Indents will have a width of 4
o.softtabstop = 2 -- Sets the number of columns for a TAB
o.expandtab = false -- Expand TABs to spaces
vim.cmd [[set mouse=a]]
vim.cmd [[set undofile]]

-- Apply Theme
o.syntax = "enable"
o.termguicolors = true
g.NERDTreeShowHidden = true
g.NERDTreeAutoDeleteBuffer = true
g.NERDTreeMinimalUI = true
g.NERDTreeDirArrows = true
g.hidden = true
g.material_theme_style = "ocean_community"
vim.cmd [[colorscheme material]]

-- KeyBindings
g.mapleader = " "
require "keymappings"

-- Remove background color
vim.cmd [[highlight Normal guibg=none]]
vim.cmd [[highlight NonText guibg=none]]

require "paq" {
  "savq/paq-nvim", -- Let Paq manage itself
  -- Theming Plugins
  {"kaicataldo/material.vim", branch = "main"},
  "ryanoasis/vim-devicons",
  -- Layout Plugins
  "preservim/nerdtree",
  "hoob3rt/lualine.nvim",
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

require "nvim-treesitter.configs".setup {ensure_installed = "maintained", highlight = {enable = true}}

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
local lsp_utils = require "lsp-utils"

opt.completeopt = {"menuone", "noinsert", "noselect"}
opt.shortmess:append({c = true})

-- Autoformat
require "autoformatter"
