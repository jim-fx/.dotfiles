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

autocmd({ "BufWritePre" }, {
  pattern = "*",
  callback = function()
    vim.lsp.buf.format()
  end
})

autocmd({ "BufWinEnter" }, {
  pattern = "qf",
  callback = function()
    vim.cmd.loadview({ mods = { emsg_silent = true } })
  end,
  group = save_fold,
})


-- Set up the autocommand for quickfix windows
autocmd("FileType", {
  pattern = "qf",
  callback = function()
    local function openInSplit()
      local current_window = vim.api.nvim_get_current_win()
      vim.cmd("copen")
      vim.cmd("normal! <C-w>h")
      vim.cmd("cclose")
      vim.cmd("normal! <C-w>L")
      vim.api.nvim_set_current_win(current_window)
      vim.cmd("execute 'cc'")
    end

    vim.api.nvim_buf_set_keymap(0, "n", "<C-v>", openInSplit, { noremap = true, silent = true })
  end,
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


autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({ async = false })
  end
})

autocmd("User", {
  pattern = "TelescopeFindPre",
  callback = function()
    vim.opt_local.winborder = "none"
    vim.api.nvim_create_autocmd("WinLeave", {
      once = true,
      callback = function()
        vim.opt_local.winborder = "rounded"
      end,
    })
  end,
})
