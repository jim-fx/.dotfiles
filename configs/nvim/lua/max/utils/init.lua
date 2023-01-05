local M = {}
local cmd = vim.cmd

function M.create_augroup(autocmds, name)
    cmd("augroup " .. name)
    cmd("autocmd!")
    for _, autocmd in ipairs(autocmds) do
        cmd("autocmd " .. table.concat(autocmd, " "))
    end
    cmd("augroup END")
end

function M.ReloadConfig()
    for name, _ in pairs(package.loaded) do
        if name:match("^cnull") then
            package.loaded[name] = nil
        end
    end

    dofile(vim.env.MYVIMRC)
end

local inspect = require("inspect")

function M.dump(o)
  print(inspect.inspect(o))
end

function M.has_plugin(pluginName)
    local status = pcall(require, pluginName)
    return status
end

return M
