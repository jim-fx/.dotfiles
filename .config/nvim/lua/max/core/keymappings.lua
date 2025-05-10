local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Set Leader key
vim.g.mapleader = " "

map('n', '<A-t>', ':term<CR>:setlocal nonumber norelativenumber<CR>i', { noremap = false, silent = true })
map('t', '<Esc>', "<C-\\><C-n><C-w>h", { silent = true })

map("n", "<Leader><leader>", "za", opts)

-- LSP Functionality
map("n", "<Leader>k", ":lua vim.diagnostic.goto_prev()<CR>", opts)
map("n", "<Leader>j", ":lua vim.diagnostic.goto_next()<CR>", opts)
map("n", "<Leader>e", ":lua vim.diagnostic.open_float()<CR>", opts)
map("n", "gD", ":lua vim.lsp.buf.declaration()<CR>", opts)
map("n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
map("n", "gi", ":lua vim.lsp.buf.implementation()<CR>", opts)
map("n", "K", ":lua vim.lsp.buf.hover()<CR>", opts)
map("n", "<Leader>rn", ":lua vim.lsp.buf.rename()<CR>", opts)

map("n", "<Leader>li", ":LspInfo<CR>", opts)
map("n", "<Leader>lr", ":LspRestart<CR>", opts)


-- This is my [i]nspect section,
map("n", "<Leader>is", ":SymbolsOutline<cr>", opts)      -- [i]nspect [s]ymbols
map("n", "<Leader>ic", ":ColorizerToggle<CR>", opts)     -- [i]nspect [c]olors
map("n", "<Leader>ic", ":Copilot panel<CR>", opts)       -- [i]nspect [c]opilot suggestions
map("n", "<Leader>in", ":Telescope notify<CR>", opts)    -- [i]nspect [n]otifications
map("n", "<Leader>ip", ":Trouble diagnostics<CR>", opts) -- [i]nspect [p]roblems

-- Navigate Buffers
-- map("n", "<C-h>", "<C-w>h", opts) -- overwritten by neotree
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
map("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
map("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)
map("n", "<A-S-K>", "yyP", opts)
map("n", "<A-S-J>", "yyp", opts)

-- indent lines like a normal human being
map("n", "<S-Tab>", "<<", opts)
map("v", "<S-Tab>", "<<", opts)
map("n", "<Tab>", ">>", opts)
map("v", "<Tab>", ">>", opts)

-- resize
map("n", "<C-Up>", ":resize -4<CR>", opts)
map("n", "<C-Down>", ":resize +4<CR>", opts)
map("n", "<C-Left>", ":vertical resize -4<CR>", opts)
map("n", "<C-Right>", ":vertical resize +4<CR>", opts)

-- If i paste with p, the replaced content doesnt replace my clipboard
map("v", "p", '"_dP', opts)
map("n", "x", '"_x', opts)

-- [cl]ear highlights after search
map("n", "<leader>cl", ":noh<CR>", opts);

map("n", "<leader>l", ":Mason<CR>", opts); -- l for [l]sp servers
map("n", "<leader>p", ":Lazy<CR>", opts);  -- p for [p]lugins

-- I aint no weak boy
map("n", "<Left>", ":echo 'No Left for you'<CR><i><dw>", opts)
map("n", "<Right>", ":echo 'No Right for you'<CR><dw>", opts)
map("n", "<Up>", ":echo 'No Up for you'<CR><dw>", opts)
map("n", "<Down>", ":echo 'No Down for you'<CR><dw>", opts)

-- Quit pro quo
map("n", "<Leader>wq", ":wqall!<CR>", opts)
map("n", "<Leader>q", ":q<CR>", opts)
map("n", "<Leader><C-q>", ":qall<CR>", opts)

-- Make ctrl+s work
map("n", "<C-s>", ":w<CR>", opts)
map("i", "<C-s>", "<Esc>:w<CR>i", opts)
