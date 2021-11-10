local cmd = vim.cmd;

cmd [[
    augroup auto_format
      au!
      au BufWritePre * silent! lua vim.lsp.buf.formatting_sync(nil, 300)<CR>
    augroup END

    augroup highlight_yank
      au!
      au TextYankPost * silent! lua vim.highlight.on_yank { timeout = 150 }
    augroup END
]]
