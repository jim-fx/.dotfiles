local cmd = vim.lsp.rpc.connect('172.29.144.1', 6005)
local util = require 'lspconfig.util'
local lsp = require 'lspconfig'

lsp.gdscript.setup {
  cmd = cmd,
  filetypes = { 'gd', 'gdscript', 'gdscript3' },
  root_dir = util.root_pattern('project.godot', '.git'),
}
