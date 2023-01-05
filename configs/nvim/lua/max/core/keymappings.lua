-- local map = vim.api.nvim_set_keymap
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local saga = require("lspsaga")
saga.init_lsp_saga()

-- Set Leader key
vim.g.mapleader = " "

map("n", "<C-o>", ":Telescope find_files preview={timeout=1000}<CR>", opts)
map("n", "<C-f>", ":lua require'telescope.builtin'.live_grep{ cwd = vim.fn.getcwd() }<CR>", opts)
map("n", "<Leader><leader>", "za", opts)

map("v", ">", ">gv", opts)
map("v", "<", "<gv", opts)

-- LSP Functionality
map("n", "<Leader>n", ":lua vim.diagnostic.goto_next()<CR>", opts)
map("n", "<Leader>p", ":lua vim.diagnostic.goto_prev()<CR>", opts)
map("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
map("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)

map("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
map("n", "<Leader>e", "<cmd>lua vim.lsp.buf.hover()<CR>", { silent = true })
map("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
map({ "n", "v" }, "<Leader>c", "<cmd>Lspsaga code_action<CR>", { silent = true })
map({ "n", "v" }, "gr", "<cmd>Lspsaga lsp_finder<CR>", opts)

map("n", "<Leader>u", ":UndotreeToggle<CR>", opts)

-- This is my [i]nspect section, [i]nspect [s]ymbols
map("n", "<Leader>is", "<cmd>lua require('litee.lib.lsp.wrappers').buf_document_symbol()<CR>", opts)
map("n", "<Leader>io", "<cmd>Lspsaga outline<CR>", opts)
map("n", "<Leader>ip", ":TroubleToggle<CR>", opts)
map({ "n", "v" }, "<Leader>t", require("max.configs.translate"), opts)

-- DAP Functionality
map("n", "<Leader>b", ":lua require('dap').toggle_breakpoint()<CR>", opts)

-- Test Functionality
map("n", "tt", ":lua require('neotest').run.run()<CR>", opts)
map("n", "to", ":lua require('neotest').summary.open()<CR>", opts)

map({ "n", "v" }, "+", "<cmd>:Boole increment<CR>", opts)
map({ "n", "v" }, "-", "<cmd>:Boole decrement<CR>", opts)

-- Navigate Buffers
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

map("n", "<Leader>1", "1gt", opts)
map("n", "<Leader>2", "2gt", opts)
map("n", "<Leader>3", "3gt", opts)
map("n", "<Leader>4", "4gt", opts)
map("n", "<Leader>0", ":tablast<CR>", opts)

-- Browser like next/previous
map("n", "<A-Left>", ":bprevious<CR>", opts)
map("n", "<A-Right>", ":bnext<CR>", opts)

-- Copy visual selection to keyboard
map("v", "Y", '"+y', opts)
map("n", "<Leader>k", "{", opts)
map("n", "<Leader>j", "}", opts)

-- Move lines vscode style
map("n", "<A-j>", "<cmd>move +1<CR>", opts)
map("n", "<A-k>", "<cmd>move -2<CR>", opts)
map("i", "<A-j>", "<cmd>move +1<CR>", opts)
map("i", "<A-k>", "<cmd>move -2<CR>", opts)
map("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
map("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)
map("n", "<A-S-K>", "yyP", opts)
map("n", "<A-S-J>", "yyp", opts)

-- If i paste with p, the replaced content doesnt replace my clipboard
map("v", "p", '"_dP', opts)

-- Faster git merge
map("n", "<Leader>gd", ":Gvdiffsplit!<CR>", opts)
map("n", "<Leader>gdl", ":diffget //3<CR>", opts)
map("n", "<Leader>gdh", ":diffget //2<CR>", opts)

-- Find file in NvimTree
map("n", "<Leader>e", ":NvimTreeToggle<CR>", opts)
map("n", "<Leader>f", ":NvimTreeFindFile<CR><c-w>", opts)

-- I aint no weak boy
map("n", "<Left>", ":echo 'No Left for you'<CR><i><dw>", opts)
map("n", "<Right>", ":echo 'No Right for you'<CR><dw>", opts)
map("n", "<Up>", ":echo 'No Up for you'<CR><dw>", opts)
map("n", "<Down>", ":echo 'No Down for you'<CR><dw>", opts)

-- Run Requests
map("n", "<Leader>r", ":SnipRun<CR>", opts)
map("v", "<Leader>r", ":'<,'>SnipRun<CR>", opts)

-- Close on q
local function closeAll()
  vim.cmd("SessionSave")
  vim.cmd("qall")
end

map("n", "<Leader>q", ":q<CR>", opts)
map("n", "<Leader><C-q>", closeAll, opts)

-- Make ctrl+s work
map("n", "<C-s>", "<Esc>:w<CR>", opts)
map("i", "<C-s>", "<Esc>:w<CR>i", opts)
