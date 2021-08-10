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
  "nvim-lua/completion-nvim",
  {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"},
  -- Formatting
  "mhartington/formatter.nvim",
  -- Git Interface
  "akinsho/nvim-toggleterm.lua"
}
-- Apply Theme
o.syntax = "enable"
o.termguicolors = true
g.NERDTreeShowHidden = true
g.material_theme_style = "ocean_community"
vim.cmd [[colorscheme material]]
vim.cmd [[highlight Normal guibg=none]]
vim.cmd [[highlight NonText guibg=none]]

local ts = require "nvim-treesitter.configs"
ts.setup {ensure_installed = "maintained", highlight = {enable = true}}

local Terminal = require("toggleterm.terminal").Terminal
local lazygit =
  Terminal:new(
  {
    cmd = "lazygit",
    dir = "git_dir",
    direction = "float",
    float_opts = {
      border = "double"
    },
    -- function to run on opening the terminal
    on_open = function(term)
      vim.cmd("startinsert!")
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
    end,
    -- function to run on closing the terminal
    on_close = function(term)
      vim.cmd("Closing terminal")
    end
  }
)

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<C-g>", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})

require("toggleterm").setup {}

-- KeyBindings
local map = vim.api.nvim_set_keymap

map("n", ",", "", {})
g.mapleader = ","

options = {noremap = true}
map("n", "<C-p>", ":Telescope find_files<CR>", options)

-- Navigate Buffers
map("n", "<C-h>", "<C-w>h", options)
map("n", "<C-j>", "<C-w>j", options)
map("n", "<C-k>", "<C-w>k", options)
map("n", "<C-l>", "<C-w>l", options)

-- Make ctrl+s work
map("n", "<C-s>", "<Esc>:w<CR>", options)
map("i", "<C-s>", "<Esc>:w<CR>i", options)

-- Update vim config
map("n", "<C-u>", "<Esc>:source $MYVIMRC<CR>", options)

-- Autocommands
u.create_augroup(
  {
    {"VimEnter", "*", "NERDTree"},
    {"VimEnter", "*", "if &filetype !=# 'gitcommit' | NERDTree | wincmd p | endif"}
  },
  "Nerdtree"
)

-- LSP Config
local lsp = require "lspconfig"
local completion = require "completion"

lsp.svelte.setup {on_attach = completion.on_attach}
-- lsp.sumneko_lua.setup {on_attach = completion.on_attach}
lsp.tsserver.setup {on_attach = completion.on_attach}

opt.completeopt = {"menuone", "noinsert", "noselect"}
opt.shortmess:append({c = true})

-- Config Formatter
u.create_augroup(
  {
    {"BufWritePost", "*.js,*.jsx,*.ts,*.tsx,*.rs,*.lua", "FormatWrite"}
  },
  "FormatAutogroup"
)

require("formatter").setup(
  {
    logging = false,
    filetype = {
      typescript = {
        -- prettier
        function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote"},
            stdin = true
          }
        end
      },
      javascript = {
        -- prettier
        function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote"},
            stdin = true
          }
        end
      },
      svelte = {
        -- prettier
        function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote"},
            stdin = true
          }
        end
      },
      lua = {
        -- luafmt
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 2, "--stdin"},
            stdin = true
          }
        end
      }
    }
  }
)

-- Linting
lsp.diagnosticls.setup {
  filetypes = {"javascript"},
  init_options = {
    linters = {
      eslint = {
        command = "./node_modules/.bin/eslint",
        rootPatterns = {".git"},
        debounce = 100,
        args = {
          "--stdin",
          "--stdin-filename",
          "%filepath",
          "--format",
          "json"
        },
        sourceName = "eslint",
        parseJson = {
          errorsRoot = "[0].messages",
          line = "line",
          column = "column",
          endLine = "endLine",
          endColumn = "endColumn",
          message = "${message} [${ruleId}]",
          security = "severity"
        },
        securities = {
          [2] = "error",
          [1] = "warning"
        }
      }
    },
    filetypes = {
      javascript = "eslint"
    },
    formatters = {
      prettier = {
        command = "./node_modules/.bin/prettier",
        args = {"--stdin-filepath", "%filepath", "--single-quote", "--print-width 120"}
      }
    },
    formatFiletypes = {
      javascript = "prettier"
    }
  }
}
