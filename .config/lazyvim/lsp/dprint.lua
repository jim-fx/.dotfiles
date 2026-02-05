---@brief
---
--- https://github.com/dprint/dprint
---
--- Pluggable and configurable code formatting platform written in Rust.
---
local disabled_formatting = {}

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    local root_dir = client.config.root_dir or vim.fn.getcwd()

    -- If the attaching client is dprint
    if client.name == "dprint" then
      disabled_formatting[root_dir] = true
      client.server_capabilities.documentFormattingProvider = true
      client.server_capabilities.documentRangeFormattingProvider = true

      for _, lsp in pairs(vim.lsp.get_clients({ bufnr = args.buf })) do
        if lsp.id ~= client.id then
          lsp.server_capabilities.documentFormattingProvider = false
          lsp.server_capabilities.documentRangeFormattingProvider = false
        end
      end
    elseif disabled_formatting[root_dir] then
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end
  end,
})

---@type vim.lsp.Config
return {
  cmd = { "dprint", "lsp" },
  filetypes = {
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
  },
  root_markers = { "dprint.json", ".dprint.json", "dprint.jsonc", ".dprint.jsonc" },
  settings = {},
}
