-- local map = vim.api.nvim_set_keymap
local map = vim.keymap.set
local g = vim.g
local translate = require("configs.translate")

local saga = require("lspsaga")
saga.init_lsp_saga()

local options = { noremap = true, silent = true }
local remap = { noremap = true }

g.mapleader = " "

-- Allows to easily exit terminal mode
-- map('t', '<Esc>', [[<C-\><C-n>]], remap)

map("n", "<C-o>", ":Telescope find_files<CR>", options)
map("n", "<C-f>", ":lua require'telescope.builtin'.live_grep{ cwd = vim.fn.getcwd() }<CR>", options)
-- map("n", "<C-p>", ":Telescope command_center<CR>", options)
map("n", "<Leader><Leader>", "za", remap)

-- LSP Functionality
map("n", "<Leader>n", ":lua vim.diagnostic.goto_next()<CR>", options)
map("n", "<Leader>p", ":lua vim.diagnostic.goto_prev()<CR>", options)
map("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", options)
map("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", options)
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", options)

map("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
-- map("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", { silent = true })
map("n", "<leader>e", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })
map("n", "<Leader>rn", "<cmd>Lspsaga rename<CR>", options)
map({ "n", "v" }, "<leader>c", "<cmd>Lspsaga code_action<CR>", { silent = true })
map({ "n", "v" }, "gr", "Lspsaga lsp_finder<CR>", options)

map("n", "<leader>t", ":TroubleToggle<CR>", remap)

map("n", "<leader>t", translate, remap)
map("v", "<leader>t", translate, remap)

-- DAP Functionality
map("n", "<Leader>b", ":lua require('dap').toggle_breakpoint()", options)

-- Test Functionality
map("n", "tt", ":lua require('neotest').run.run()<CR>", options)
map("n", "to", ":lua require('neotest').summary.open()<CR>", options)

map({ "n", "v" }, "+", "<cmd>:Boole increment<CR>", options)
map({ "n", "v" }, "-", "<cmd>:Boole decrement<CR>", options)

-- Navigate Buffers
map("n", "<C-h>", "<C-w>h", options)
map("n", "<C-j>", "<C-w>j", options)
map("n", "<C-k>", "<C-w>k", options)
map("n", "<C-l>", "<C-w>l", options)

map("n", "<Leader>1", "1gt", options)
map("n", "<Leader>2", "2gt", options)
map("n", "<Leader>3", "3gt", options)
map("n", "<Leader>4", "4gt", options)
map("n", "<Leader>0", ":tablast<CR>", options)

map("n", "m", ":lua require('harpoon.mark').add_file()<CR>", options)
-- Navigate Files
map("n", "<S-t>", ":Telescope harpoon marks<CR>", options)

-- Handling Splits
map("n", "<C-w>h", ":sp<CR>", remap) -- horizontal
map("n", "<C-w>v", ":vs<CR>", remap) -- vertical

-- Browser like next/previous
map("n", "<A-Left>", ":bprevious<CR>", options)
map("n", "<A-Right>", ":bnext<CR>", options)

-- Backspace Delete like Browser
map("i", "<C-H>", "<Esc>dbxi", options)

-- Copy visual selection to keyboard
map("v", "Y", '"+y', options)
map("n", "<Leader>k", "{", options)
map("n", "<Leader>j", "}", options)

-- I dont use macros at the moment, can disable this if i want to
-- map('v', 'Q', 'q', {})
-- map('v', 'Q', 'q', {})
-- map('n', 'q', '<nop>', {})
-- map('n', 'q', '<nop>', {})

-- Move lines vscode style
map("n", "<A-j>", "<cmd>move +1<CR>", options)
map("n", "<A-k>", "<cmd>move -2<CR>", options)
map("i", "<A-j>", "<cmd>move +1<CR>", options)
map("i", "<A-k>", "<cmd>move -2<CR>", options)
map("v", "<A-j>", ":m '>+1<CR>gv=gv", options)
map("v", "<A-k>", ":m '<-2<CR>gv=gv", options)
map("n", "<A-S-k>", "YP", options)
map("n", "<A-S-j>", "Yp", options)

-- Faster git merge
map("n", "<Leader>gd", ":Gvdiffsplit!<CR>", options)
map("n", "<Leader>gdl", ":diffget //3<CR>", options)
map("n", "<Leader>gdh", ":diffget //2<CR>", options)

-- Find file in NvimTree
map("n", "<Leader>f", ":NvimTreeFindFile<CR><c-w>", options)

map("n", "<C-->", ":vsplit<CR>", options)
map("n", "<C-|>", ":split<CR>", options)

-- I aint no weak boy
map("n", "<Left>", ":echo 'No Left for you'<CR><i><dw>", options)
map("n", "<Right>", ":echo 'No Right for you'<CR><dw>", options)
map("n", "<Up>", ":echo 'No Up for you'<CR><dw>", options)
map("n", "<Down>", ":echo 'No Down for you'<CR><dw>", options)

-- Run Requests
map("n", "<Leader>r", ":SnipRun<CR>", options)
map("v", "<Leader>r", ":'<,'>SnipRun<CR>", options)

-- Close on q
map("n", "<Leader>q", "<Esc>:q<CR>", options)
map("n", "<Leader><C-q>", "<Esc>:qall<CR>", options)

-- Open Nerdtree
map("n", "<C-n>", ":NvimTreeToggle<CR>", options)

-- Make ctrl+s work
map("n", "<C-s>", "<Esc>:w<CR>", options)
map("i", "<C-s>", "<Esc>:w<CR>i", options)
