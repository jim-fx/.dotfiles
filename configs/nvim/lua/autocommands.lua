local cmd = vim.cmd

cmd [[
    augroup highlight_yank
      au!
      au TextYankPost * silent! lua vim.highlight.on_yank { timeout = 150 }
    augroup END
]]

cmd [[
  au ColorScheme * hi Normal ctermbg=none guibg=none
  au ColorScheme myspecialcolors hi Normal ctermbg=red guibg=red
]]

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

vim.api.nvim_create_autocmd("BufWritePre",{
  callback = function()
    vim.lsp.buf.formatting_sync();
  end
})
