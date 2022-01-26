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
