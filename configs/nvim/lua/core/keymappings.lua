local map = vim.api.nvim_set_keymap
local g = vim.g

local options = {noremap = true}
local remap = {noremap = false}

g.mapleader = " "

map("n", "<C-o>", ":Telescope find_files<CR>", options)
map("n", "<C-f>", ":Telescope live_grep<CR>", options)
map("n","<C-p>",":Telescope command_center<CR>",options)
map("n", "<Shift>", "za", options)

-- LSP Functionality
map("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", options)
map("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", options)
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", options)
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", options)
map("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", options)
map("n", "<Leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", options)
map("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", options)
map("n", "<Leader>c", "<cmd>lua vim.lsp.buf.code_action()<CR>", options)
-- map("n", "<Leader><C-f>", ":Neoformat<CR>", options)
map("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", options)
map("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", options)
map("n", "<leader>t", ":TroubleToggle<CR>", remap)

-- Navigate Buffers
map("n", "<C-h>", "<C-w>h", options)
map("n", "<C-j>", "<C-w>j", options)
map("n", "<C-k>", "<C-w>k", options)
map("n", "<C-l>", "<C-w>l", options)

-- Browser like next/previous
map("n", "<A-Left>", ":bprevious<CR>",options);
map("n", "<A-Right>", ":bnext<CR>",options);

-- Backspace Delete like Browser
map('i', '<C-H>', '<Esc>caw', options)

map("n", "Y", "yy", options)
map("n", "<Leader>k", "{", options)
map("n", "<Leader>j", "}", options)

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

map("n", "<C-->",":vsplit<CR>",options);
map("n", "<C-|>",":split<CR>",options);

-- I aint no weak boy
map("n", "<Left>", ":echo 'No Left for you'<CR><i><dw>", options)
map("n", "<Right>", ":echo 'No Right for you'<CR><dw>", options)
map("n", "<Up>", ":echo 'No Up for you'<CR><dw>", options)
map("n", "<Down>", ":echo 'No Down for you'<CR><dw>", options)

-- Run Requests
map("n", "<Leader>r", "<cmd>lua require('rest-nvim').run()<CR>", options)

-- Close on q
map("n", "<Leader>q", "<Esc>:q<CR>", options)

-- Open Nerdtree
map("n", "<C-n>", ":NvimTreeToggle<CR>", options)

-- Make ctrl+s work
map("n", "<C-s>", "<Esc>:w<CR>", options)
map("i", "<C-s>", "<Esc>:w<CR>i", options)

-- Update vim config
map("n", "<C-u>", "<Esc>:source $MYVIMRC<CR>", options)
