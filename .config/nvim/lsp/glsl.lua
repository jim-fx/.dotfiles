return {
  cmd = { 'glslls' }, -- GLSL lsp executable from (https://github.com/svenstaro/glsl-language-server
  filetypes = { 'glsl', 'vs', 'fs' },
  root_marker = util.root_pattern('compile_commands.json', '.git'),
  single_file_support = true,
  capabilities = default_capabilities,
}
 
