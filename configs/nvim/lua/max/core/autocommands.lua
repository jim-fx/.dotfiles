local config_group = vim.api.nvim_create_augroup("Config", {})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  group = config_group,
  callback = function()
    vim.highlight.on_yank()
  end,
})

local rememberFoldsGroup = vim.api.nvim_create_augroup("RememberFolds", { clear = true })

vim.api.nvim_create_autocmd({ "BufWinLeave", "BufLeave" }, {
  pattern = "*",
  group = rememberFoldsGroup,
  command = "mkview",
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*",
  group = rememberFoldsGroup,
  command = "silent! loadview",
})

vim.cmd([[
augroup filetypedetect
  au BufNewFile,BufRead *.frag setl ft=glsl
  au BufNewFile,BufRead *.vert setl ft=glsl
augroup END
]])

vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  pattern = "*",
  group = config_group,
  command = "filetype detect",
})
