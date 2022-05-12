local lsp_installer = require("nvim-lsp-installer")
lsp_installer.setup {
  ensure_installed = { "sumneko_lua", "jsonls", "tsserver", "svelte", "cssls" }
}
local lsp = require "lspconfig"

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lsp.sumneko_lua.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = runtime_path
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" }
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true)
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false
      }
    }
  }
}


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lsp.jsonls.setup {
  capabilities = capabilities,
  settings = {
    json = {
      schemas = {
        {
          description = 'TypeScript compiler configuration file',
          fileMatch = { 'tsconfig.json', 'tsconfig.*.json' },
          url = 'http://json.schemastore.org/tsconfig'
        },
        {
          description = 'ESLint config',
          fileMatch = { '.eslintrc.json', '.eslintrc' },
          url = 'http://json.schemastore.org/eslintrc'
        },
        {
          description = 'Prettier config',
          fileMatch = { '.prettierrc', '.prettierrc.json', 'prettier.config.json' },
          url = 'http://json.schemastore.org/prettierrc'
        },
      }
    },
  }
}

lsp.svelte.setup {}
lsp.tsserver.setup {}
lsp.html.setup {}
lsp.intelephense.setup {}
lsp.cssls.setup {}

lsp.ltex.setup {
  cmd = { os.getenv("HOME") .. '/.local/share/nvim/lsp_servers/ltex/ltex-ls/bin/ltex-ls' },
  settings = {
    ltex = {
      disabledRules = { ['en-US'] = { 'PROFANITY' } },
      dictionary = {
        ['en-US'] = { 'perf', 'ci' },
      },
    },
  },
}
