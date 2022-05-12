local has_impatient, impatient = pcall(require, "impatient")
if has_impatient then
  impatient.enable_profile()
end

require "core.plugins"

local status_ok = pcall(require, "nightfox")
if not status_ok then
  return
end


require "core.options"
require "core.autocommands"
require "core.theme"
require "core.keymappings"

require "configs.dashboard"
require "configs.command-center"
require "configs.notify"
require "configs.lsp"
require "configs.telescope"
require "configs.tree"
require "configs.treesitter"
require "configs.autocomplete"
require "configs.snippets"

require "overlays"
