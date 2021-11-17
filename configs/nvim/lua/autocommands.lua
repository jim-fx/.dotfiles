local cmd = vim.cmd;

cmd [[
    augroup auto_format
      au!
      au BufWritePre * FormatSync
    augroup END

    augroup highlight_yank
      au!
      au TextYankPost * silent! lua vim.highlight.on_yank { timeout = 150 }
    augroup END
]]
