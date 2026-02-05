local filetypes = {
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "json",
  "jsonc",
  "markdown",
  "python",
  "toml",
  "rust",
  "roslyn",
  "graphql",
  "svelte",
}

return {
  cmd = { "dprint", "lsp" },
  filetypes = filetypes,
  root_markers = { "dprint.json", ".dprint.json", "dprint.jsonc", ".dprint.jsonc" },
  settings = {},
}
