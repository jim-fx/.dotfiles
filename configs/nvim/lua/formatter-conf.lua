local cmd = vim.cmd;

cmd [[
    augroup auto_format
      au!
      au BufWritePre * FormatSync
    augroup END
]]
