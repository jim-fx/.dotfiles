local cmd = vim.cmd

local config_group = vim.api.nvim_create_augroup('Config', {})
vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
  group = config_group,
  callback = function()
    vim.highlight.on_yank()
  end,
})

cmd [[
augroup filetypedetect
  au BufNewFile,BufRead *.frag setl ft=glsl
  au BufNewFile,BufRead *.vert setl ft=glsl
augroup END
]]

cmd [[
augroup SaveManualFolds
    autocmd!
    au BufWinLeave, BufLeave ?* silent! mkview
    au BufWinEnter           ?* silent! loadview
augroup END
]]

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.formatting_sync();
  end
})
