-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<Leader>k", ":lua vim.diagnostic.goto_prev()<CR>")
vim.keymap.set("n", "<Leader>j", ":lua vim.diagnostic.goto_next()<CR>")

-- Browser like next/previous for navigating the jumplist
vim.keymap.set("n", "<A-Left>", "<C-O>")
vim.keymap.set("n", "<A-Right>", "<C-I>")
