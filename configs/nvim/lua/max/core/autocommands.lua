local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local config_group = vim.api.nvim_create_augroup("Config", {})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  group = config_group,
  callback = function()
    vim.highlight.on_yank()
  end,
})


vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  group = config_group,
  callback = function()
    vim.cmd("filetype detect")
  end,
})


local save_fold = augroup("Persistent Folds", { clear = true })
autocmd("BufWinLeave", {
  pattern = "*.*",
  callback = function()
    vim.cmd.mkview()
  end,
  group = save_fold,
})
autocmd("BufWinEnter", {
  pattern = "*.*",
  callback = function()
    vim.cmd.loadview({ mods = { emsg_silent = true } })
  end,
  group = save_fold,
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
