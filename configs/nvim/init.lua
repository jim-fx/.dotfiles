require("utils.install-packer")

local u = require("utils")
if u.has_plugin("packer") then
  local packer = require("packer")
  packer.init {
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  require "core.plugins"
  require "impatient"

  require "core.options"
  require "core.autocommands"
  require "core.keymappings"
  require "core.theme"

  require "configs.dashboard"
  require "configs.command-center"
  require "configs.notify"
  require "configs.lsp"
  require "configs.lspinstaller"
  require "configs.telescope"
  require "configs.tree"
  require "configs.treesitter"
  require "configs.autocomplete"
  require "configs.snippets"

  require "overlays"

  require "nvim-autopairs".setup()
else
  vim.cmd [[PackerSync]]
  vim.cmd [[echo Installed -> Reload]]
end
