vim.opt.termguicolors = true

require("core.bootstrap")
require("core.plugins")

require("core.options")
require("core.autocommands")
require("core.keymappings")

require("configs.dashboard")
require("configs.lsp")
require("configs.dap")

require("theme.catpuccin")

require("overlays")
