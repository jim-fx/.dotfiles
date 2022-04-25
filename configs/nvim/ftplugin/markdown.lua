local map = vim.api.nvim_set_keymap


map("i", "<C-b>", ">a**<esc><i**<esc>", { noremap = true })
