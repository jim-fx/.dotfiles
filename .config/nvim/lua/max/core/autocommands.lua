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

-- autocmd('FileType', {
--   callback = function(tbl)
--     local set_offset = require('bufferline.api').set_offset
--
--     local bufwinid
--     local last_width
--     local _autocmd = vim.api.nvim_create_autocmd('WinScrolled', {
--       callback = function()
--         bufwinid = bufwinid or vim.fn.bufwinid(tbl.buf)
--
--         local width = vim.api.nvim_win_get_width(bufwinid)
--         if width ~= last_width then
--           set_offset(width, '')
--           last_width = width
--         end
--       end,
--     })
--
--     vim.api.nvim_create_autocmd('BufWipeout', {
--       buffer = tbl.buf,
--       callback = function()
--         vim.api.nvim_del_autocmd(_autocmd)
--         set_offset(0)
--       end,
--       once = true,
--     })
--   end,
--   pattern = 'neo-tree', -- or any other filetree's `ft`
-- })

local save_fold = augroup("Persistent Folds", { clear = true })
autocmd({ "BufWinLeave" }, {
  pattern = "*.*",
  callback = function()
    vim.cmd.mkview()
  end,
  group = save_fold,
})

autocmd({ "BufReadPost" }, {
  pattern = "*.http",
  callback = function()
    vim.bo.filetype = "http"
  end,
  group = save_fold,
})

autocmd({ "BufWinEnter" }, {
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
