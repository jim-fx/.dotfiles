local map = vim.api.nvim_set_keymap
local g = vim.g

options = {noremap = true}
remap = {noremap = false}

map("n", "<Space>", "<Nop>", remap)
map("n", " ", "<Nop>", remap)
g.mapleader = " "

map("n", "<C-p>", ":Telescope find_files<CR>", options)
map("n", "<C-f>", ":Telescope grep_string<CR>", options)
map("n", "<C-S-f>", ":Telescope live_grep<CR>", options)
-- Navigate Buffers
map("n", "<C-h>", "<C-w>h", options)
map("n", "<C-j>", "<C-w>j", options)
map("n", "<C-k>", "<C-w>k", options)
map("n", "<C-l>", "<C-w>l", options)

-- Find file in NvimTree
map("n", "<C-f>", ":NvimTreeFindFile<CR><c-w>", options)

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

-- Y yank until the end of line
map("n", "Y", "y$", {noremap = true})
