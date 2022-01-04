local cmd = vim.cmd

cmd [[
    augroup auto_format
      au!
      au BufWritePre * Neoformat
    augroup END
]]
