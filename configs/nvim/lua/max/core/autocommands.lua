local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local config_group = augroup("Config", {})

autocmd({ "TextYankPost" }, {
  group = config_group,
  callback = function()
    vim.highlight.on_yank()
  end,
})

autocmd({ "BufReadPost" }, {
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

require("max.theme.statuscolumn");

autocmd({ "BufWinEnter","BufAdd" }, {
  desc = 'hide statuscolumn in nvimtree',
  group = vim.api.nvim_create_augroup('hide_nvimtree_stc', { clear = true }),
  callback = function(opts)
    if vim.bo[opts.buf].filetype == 'NvimTree' then
      vim.opt.statuscolumn = ''
    else
      -- vim.o.statuscolumn = '%=%r%s%#FoldColumn#%{foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? "" : "") : " " } %*'
      vim.opt.statuscolumn = [[%!v:lua.Status.column()]]
    end
  end,
})

vim.cmd [[au BufWinEnter NvimTree setlocal statuscolumn=""]]

vim.cmd([[
augroup filetypedetect
  au BufNewFile,BufRead *.frag setl ft=glsl
  au BufNewFile,BufRead *.vert setl ft=glsl
  au BufNewFile,BufRead tsconfig.json setl ft=jsonc
augroup END
]])

autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
