-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<Leader>k", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
vim.keymap.set("n", "<Leader>j", "<cmd>lua vim.diagnostic.goto_next()<CR>")

vim.keymap.set("n", "<A-,>", "<cmd>BufferLineCyclePrev<CR>")
vim.keymap.set("n", "<A-.>", "<cmd>BufferLineCycleNext<CR>")
vim.keymap.set("n", "<A-w>", "<cmd>bdelete<CR>");
vim.keymap.set("n", "<S-A-w>", "<cmd>BufferLineCloseOthers<CR>");

-- Browser like next/previous for navigating the jumplist
vim.keymap.set("n", "<A-Left>", "<C-O>")
vim.keymap.set("n", "<A-Right>", "<C-I>")

-- [cl]ear highlights after search
vim.keymap.set("n", "<leader>cl", "<cmd>noh<CR>");

-- If i paste with p, the replaced content doesnt replace my clipboard
vim.keymap.set("v", "p", '"_dP')
vim.keymap.set("n", "x", '"_x')

-- Resume last search
vim.keymap.set("n", "<leader>sr", "<cmd>FzfLua resume<CR>")
