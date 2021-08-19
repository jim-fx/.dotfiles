local o = vim.o
local opt = vim.opt
local wo = vim.wo
local bo = vim.bo
local g = vim.g
local fn = vim.fn

require("install-paq")
require("paq"):setup({verbose=true}) {
  "savq/paq-nvim", -- Let Paq manage itself
  -- Theming Plugins
  {url="git@github.com:kaicataldo/material.vim", branch = "main"},
  {url="git@github.com:ryanoasis/vim-devicons"},
  -- Layout Plugins
  {url="git@github.com:preservim/nerdtree"},
  {url="git@github.com:hoob3rt/lualine.nvim"},
  -- Code Navigation
  {url="git@github.com:nvim-lua/popup.nvim"},
  {url="git@github.com:nvim-lua/plenary.nvim"},
  {url="git@github.com:nvim-telescope/telescope.nvim"},
  -- Syntax / Autocomplete
  {url="git@github.com:neovim/nvim-lspconfig"},
  {url="git@github.com:nvim-lua/lsp-status.nvim"},
  {url="git@github.com:hrsh7th/nvim-compe"},
  {url="git@github.com:nvim-treesitter/nvim-treesitter", run = ":TSUpdate"},
  -- Formatting
  {url="git@github.com:mhartington/formatter.nvim"},
  -- Git Interface
  {url="git@github.com:akinsho/nvim-toggleterm.lua"}
}

local u = require("utils")


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

if u.has_plugin("material") then
  vim.cmd [[colorscheme material]]
end
-- Remove background color
vim.cmd [[highlight Normal guibg=none]]
vim.cmd [[highlight NonText guibg=none]]

-- KeyBindings
g.mapleader = " "
require "keymappings"

-- Treesitter config
if u.has_plugin("nvim-treesitter") then
  require "nvim-treesitter.configs".setup {ensure_installed = "maintained", highlight = {enable = true}}
end
-- Toggleterm / Lazygit setup
if u.has_plugin("toggleterm") then
  require "lazy-git"
end
-- Autocommands
if u.has_plugin("NERDTree") then
  u.create_augroup(
    {
      {"VimEnter", "*", "if (@% == '') | NERDTree | endif"},
      {"BufEnter", "*", 'if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif'}
    },
    "Nerdtree"
  )
end

-- Autocompletion Setup
if u.has_plugin("compe") then
  require "autocomplete"
end

-- LSP Config
if u.has_plugin("lspconfig") then

require "lsp-utils"

opt.completeopt = {"menuone", "noinsert", "noselect"}
opt.shortmess:append({c = true})

-- Autoformat
require "autoformatter"

end