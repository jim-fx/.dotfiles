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

local function dump(o)
    if type(o) == "table" then
        local s = "{ "
        for k, v in pairs(o) do
            if type(k) ~= "number" then
                k = '"' .. k .. '"'
            end
            s = s .. "[" .. k .. "] = " .. dump(v) .. ","
        end
        return s .. "} "
    else
        return tostring(o)
    end
end

M.dump = dump

function M.has_plugin(pluginName)
    local status = pcall(require, pluginName)
    return status
end

return M
