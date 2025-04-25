return {
  cmd = { 'glslls' }, -- GLSL lsp executable from (https://github.com/svenstaro/glsl-language-server
  filetypes = { 'glsl', 'vs', 'fs' },
  root_marker = { 'compile_commands.json', '.git' },
  single_file_support = true,
}
