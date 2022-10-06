-- Automatically close the goto definition buffer after leaving
local buffer_id = vim.api.nvim_win_get_buf(0)
vim.api.nvim_create_autocmd({ "bufwinleave", "bufleave" }, {
  pattern = "*",
  once = true,
  command = "bdelete " .. buffer_id,
})
