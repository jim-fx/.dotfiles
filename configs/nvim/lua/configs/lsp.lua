local lsp_installer = require("nvim-lsp-installer")
lsp_installer.setup {
  ensure_installed = { "sumneko_lua", "jsonls", "tsserver", "svelte", "cssls" }
}
local lsp = require "lspconfig"

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local function on_attach(client, bufnr)
  local cap = client.server_capabilities

  if (cap.documentFormattingProvider) then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format();
      end
    })
  else
    vim.notify("Lsp (" .. client.name .. ") doesnt support format")
  end
end

lsp.sumneko_lua.setup {
  on_attach = on_attach,
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
  on_attach = on_attach,
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

lsp.svelte.setup {
  on_attach = on_attach
}
lsp.tsserver.setup {
  on_attach = on_attach
}
lsp.html.setup {
  on_attach = on_attach
}
lsp.intelephense.setup {
  on_attach = on_attach
}
lsp.cssls.setup {
  on_attach = on_attach
}

lsp.bashls.setup {
  filetypes = { "sh", "bash" },
  on_attach = on_attach
}

-- lsp.remark_ls.setup {
--   filetypes = { "markdown" },
--   on_attach = on_attach
-- }

lsp.ltex.setup {
  on_attach = on_attach,
  cmd = { os.getenv("HOME") .. '/.local/share/nvim/lsp_servers/ltex/ltex-ls/bin/ltex-ls' },
  settings = {
    ltex = {
      disabledRules = { ['en-US'] = { 'PROFANITY' } },
      dictionary = {
        ['en-US'] = { 'perf', 'ci', 'neovim' },
      },
      hiddenFalsePositives = {
        'neovim',
        'Neovim',
        'waybar'
      }
    },
  },
}
