local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Set Leader key
vim.g.mapleader = " "

-- Telescope
map("n", "<C-o>", ":Telescope find_files preview={timeout=1000}<CR>", opts)
map("n", "<C-f>", ":Telescope live_grep<CR>", opts)
map("n", "<leader>o", ":Telescope buffers<CR>", opts)


map('n', '<A-t>', ':term<CR>:setlocal nonumber norelativenumber<CR>i', { noremap = false, silent = true })
map('t', '<Esc>', "<C-\\><C-n><C-w>h", { silent = true })

map("n", "<Leader><leader>", "za", opts)

local function zenMode()
  vim.cmd("Neotree close");
  vim.cmd("NoNeckPain");
end

map("n", "<Leader>z", zenMode, opts);
map("n", "<Leader>a", ":Alpha<CR>", opts);

-- LSP Functionality
map("n", "<Leader>n", ":lua vim.diagnostic.goto_next()<CR>", opts)
map("n", "<Leader>p", ":lua vim.diagnostic.goto_prev()<CR>", opts)
map("n", "<Leader>e", ":lua vim.diagnostic.open_float()<CR>", opts)
map("n", "gD", ":lua vim.lsp.buf.declaration()<CR>", opts)
map("n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
map("n", "gi", ":lua vim.lsp.buf.implementation()<CR>", opts)
map("n", "K", ":lua vim.lsp.buf.hover()<CR>", opts)

map("n", "<Leader>rn", ":lua vim.lsp.buf.rename()<CR>", opts)
map({ "n", "v" }, "<Leader>c", ":Lspsaga code_action<CR>", { silent = true })
map({ "n", "v" }, "gr", ":Lspsaga lsp_finder<CR>", opts)

map("n", "<Leader>u", ":UndotreeToggle<CR>", opts)
map("n", "<Leader>wq", ":wqall!<CR>", opts)
map("n", "<Leader>li", ":LspInfo<CR>", opts)
map("n", "<Leader>lr", ":LspRestart<CR>", opts)

-- barbar.nvim
map('n', '<A-,>', '<Cmd>BufferLineCyclePrev<CR>', opts)
map('n', '<A-.>', '<Cmd>BufferLineCycleNext<CR>', opts)

local bufferline = require("bufferline");
for i = 1, 81 do
  map('n', '<A-' .. i .. '>', function() bufferline.go_to(i, true) end, opts)
end

map('n', '<A-w>', '<Cmd>bdelete<CR>', opts)

-- This is my [i]nspect section,
map("n", "<Leader>is", ":SymbolsOutline<cr>", opts)          -- [i]nspect [s]ymbols
map("n", "<Leader>ic", ":ColorizerToggle<CR>", opts)         -- [i]nspect [c]olors
map("n", "<Leader>io", ":Lspsaga outline<CR>", opts)         -- [i]nspect [o]utline
map("n", "<Leader>in", ":Telescope notify<CR>", opts)        -- [i]nspect [n]otifications
map("n", "<Leader>ip", ":TroubleToggle<CR>", opts)           -- [i]nspect [p]roblems
map("n", "<Leader>ii", ":Lspsaga incomming_calls<CR>", opts) -- [i]nspect [i]ncomming_calls
map("n", "<Leader>io", ":Lspsaga outgoing_calls<CR>", opts)  -- [i]nspect [o]utgoing_calls
map("n", "<Leader>ic", ":Copilot panel<CR>", opts)           -- [i]nspect [c]opilot suggestions

map("v", "<Leader>ai", ":'<,'>NeoAIContext<CR>")
map("n", "<Leader>ai", ":NeoAI<CR>")

map({ "n", "v" }, "<Leader>t", require("max.functions.translate"), opts)

-- DAP Functionality
map("n", "<Leader>b", ":lua require('dap').toggle_breakpoint()<CR>", opts)

-- Test Functionality
map("n", "tt", ":lua require('neotest').run.run()<CR>", opts)
map("n", "to", ":lua require('neotest').summary.open()<CR>", opts)

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

-- Browser like next/previous for navigating the jumplist
map("n", "<A-Left>", "<C-O>", opts)
map("n", "<A-Right>", "<C-I>", opts)

-- Copy visual selection to keyboard
map("v", "Y", '"+y', opts)
map("n", "<Leader-k>", "{", opts)
map("n", "<Leader-j>", "}", opts)

-- Move lines vscode style
map("n", "<A-j>", ":move +1<CR>", opts)
map("n", "<A-k>", ":move -2<CR>", opts)
map("i", "<A-j>", ":move +1<CR>", opts)
map("i", "<A-k>", ":move -2<CR>", opts)
map("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
map("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)
map("n", "<A-S-K>", "yyP", opts)
map("n", "<A-S-J>", "yyp", opts)
map("v", ">", ">gv", opts)
map("v", "<", "<gv", opts)

-- resize
map("n", "<C-Up>", ":resize -4<CR>", opts)
map("n", "<C-Down>", ":resize +4<CR>", opts)
map("n", "<C-Left>", ":vertical resize -4<CR>", opts)
map("n", "<C-Right>", ":vertical resize +4<CR>", opts)


-- If i paste with p, the replaced content doesnt replace my clipboard
map("v", "p", '"_dP', opts)

-- clear highlights after search
map("n", "<leader>cl", ":noh<CR>", opts);

map("n", "<leader>m", ":Mason<CR>", opts);
map("n", "<leader>l", ":Lazy<CR>", opts);

-- Find file in NeoTree
map("n", "<Leader>j", ":Neotree toggle<CR>", opts)
map("n", "<Leader>f", ":Neotree action=focus reveal=true<CR>", opts)

-- I aint no weak boy
map("n", "<Left>", ":echo 'No Left for you'<CR><i><dw>", opts)
map("n", "<Right>", ":echo 'No Right for you'<CR><dw>", opts)
map("n", "<Up>", ":echo 'No Up for you'<CR><dw>", opts)
map("n", "<Down>", ":echo 'No Down for you'<CR><dw>", opts)

-- Run Scripts
map("n", "<Leader>r", ":SnipRun<CR>", opts)
map("v", "<Leader>r", ":'<,'>SnipRun<CR>", opts)

map("n", "<Leader>q", ":q<CR>", opts)
map("n", "<Leader><C-q>", ":qall<CR>", opts)

-- Make ctrl+s work
map("n", "<C-s>", ":w<CR>", opts)
map("i", "<C-s>", "<Esc>:w<CR>i", opts)
