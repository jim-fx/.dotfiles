require("max.core.bootstrap")

require("max.core.options")

require("max.core.plugins")

require("max.core.autocommands")

require("max.core.keymappings")

vim.cmd("colorscheme " .. require("max.plugins.theme").name);

-- Prepend mise shims to PATH
vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH
