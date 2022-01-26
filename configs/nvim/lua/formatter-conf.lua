local cmd = vim.cmd
local util = require "vim.lsp.util"
local utils = require("utils")

function tablelength(T)
    local count = 0
    for _ in pairs(T) do
        count = count + 1
    end
    return count
end

local function select_client(method)
    local all_clients = vim.tbl_values(vim.lsp.buf_get_clients())

    local supported_client
    local found_client = false
    for _, client in ipairs(all_clients) do
        local supports = client.supports_method(method)
        if supports then
            found_client = true
            supported_client = client
        end
    end

    if not found_client then
        return nil
    end

    return supported_client
end

function FormattingSync()
    vim.cmd("Neoformat")

    --     local client = select_client("textDocument/formatting")
    --     if client == nil then
    --         vim.notify("No LSP Client with formatting connected")
    --     end

    --     vim.notify("Formatting with LSP")

    --     local params = util.make_formatting_params({})
    --     local result, err = client.request_sync("textDocument/formatting", params, 500, vim.api.nvim_get_current_buf())
    --     if result and result.result then
    --         util.apply_text_edits(result.result)
    --     elseif err then
    --         vim.notify("vim.lsp.buf.formatting_sync: " .. err, vim.log.levels.WARN)
    --     end
end

vim.cmd [[command! Format lua FormattingSync()]]

cmd [[
    augroup auto_format
      au!
      au BufWritePre * lua FormattingSync()
    augroup END
]]
