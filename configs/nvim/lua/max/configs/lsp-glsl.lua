local status_ok, util = pcall(require, "lspconfig.util")

if not status_ok then
  return
end

local default_capabilities = vim.lsp.protocol.make_client_capabilities()
default_capabilities.textDocument.completion = false
default_capabilities.textDocument.synchronization.didSave = false;

local default_config = {
  cmd = { 'glslls' }, -- GLSL lsp executable from (https://github.com/svenstaro/glsl-language-server
  filetypes = { 'glsl', 'vs', 'fs' },
  root_dir = util.root_pattern('compile_commands.json', '.git'),
  single_file_support = true,
  capabilities = default_capabilities,
}

return {
  capabilities = default_capabilities,
  default_configs = default_config,
  commands = {},
  docs = {
    description = [[
            Basic LSP support for GLSL using glslls --stdio
        ]]
  },
}
