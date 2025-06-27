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

-- local save_fold = augroup("Persistent Folds", { clear = true })
-- autocmd({ "BufWinLeave" }, {
--   pattern = "*.*",
--   callback = function()
--     vim.cmd.mkview()
--   end,
--   group = save_fold,
-- })

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
autocmd({ "FileType" }, {
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
  end
})

autocmd({ "LspAttach" }, {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end

    if client:supports_method('textDocument/documentColor') then
      if vim.lsp.document_color ~= nil then
        vim.lsp.document_color.enable(true, args.buf)
      end
    end

    autocmd({ "BufWritePre" }, {
      buffer = args.buf,
      callback = function()
        local range = vim.lsp.util.make_range_params(0, client.offset_encoding)
        local params = {
          textDocument = range.textDocument,
          range = range.range,
          context = { only = { 'source.organizeImports', 'source.fixAll' } }
        }
        if client.supports_method("textDocument/codeAction", { bufnr = args.buf }) then
          vim.lsp.buf_request(args.buf, 'textDocument/codeAction', params, function(err, res)
            if res then
              for _, r in ipairs(res) do
                if r.edit then vim.lsp.util.apply_workspace_edit(r.edit, client.offset_encoding) end
                if r.command then client:exec_cmd(r.command, { bufnr = args.buf }) end
              end
            end
          end)
        end
      end
    })
  end
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

autocmd({ "BufWritePost" }, {
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
});

autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
});
