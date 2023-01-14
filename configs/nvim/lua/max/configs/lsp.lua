local mason = require("mason")
local mason_lsp = require("mason-lspconfig")
local lsp = require("lspconfig")


require("null-ls").setup({
  sources = {
    require("null-ls").builtins.formatting.stylua,
    require("null-ls").builtins.diagnostics.eslint,
    -- require("null-ls").builtins.code_actions.eslint_d,
    -- require("null-ls").builtins.completion.spell,
  },
})

mason.setup()

mason_lsp.setup({
  ensure_installed = { "sumneko_lua", "jsonls", "tsserver", "svelte", "cssls" },
})

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local function on_attach(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format()

        if client.name == "tsserver" or client.name == "svelte" then
          -- params for the request
          local params = {
            command = "_typescript.organizeImports",
            arguments = { vim.api.nvim_buf_get_name(bufnr) },
            title = "",
          }

          -- perform a syncronous request
          -- 500ms timeout depending on the size of file a bigger timeout may be needed
          vim.lsp.buf_request_sync(bufnr, "workspace/executeCommand", params, 500)
        end
      end,
    })
  else
    -- vim.notify("Lsp (" .. client.name .. ") doesnt support format")
  end
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}
capabilities.textDocument.completion.completionItem.snippetSupport = true

local custom_lsp = {};

custom_lsp.tsserver = {
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = lsp.util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git"),
}

custom_lsp.sumneko_lua = {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}


custom_lsp.jsonls = {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    provideFormatter = false,
    json = {
      schemas = {
        {
          description = "TypeScript compiler configuration file",
          fileMatch = { "tsconfig.json", "tsconfig.*.json" },
          url = "http://json.schemastore.org/tsconfig",
        },
        {
          description = "ESLint config",
          fileMatch = { ".eslintrc.json", ".eslintrc" },
          url = "http://json.schemastore.org/eslintrc",
        },
        {
          description = "Prettier config",
          fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" },
          url = "http://json.schemastore.org/prettierrc",
        },
        {
          description = "JSON schema for Import Maps files",
          fileMatch = { "importmap.json", "import_map.json", "import-map.json" },
          name = "importmap.json",
          url = "https://json.schemastore.org/importmap.json",
        },
        {
          description = "NPM configuration file",
          fileMatch = { "package.json" },
          name = "package.json",
          url = "https://json.schemastore.org/package.json",
        },
      },
    },
  },
}

custom_lsp.intelephense = {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    intelephense = {
      stubs = {
        "wordpress",
        "woocommerce",
        "wordpress-globals",
        "wp-cli",
      },
      environment = {
        includePaths = "/home/max/.composer/vendor/php-stubs/", -- this line forces the composer path for the stubs in case inteliphense don't find it...
      },
      files = {
        maxSize = 5000000,
      },
    },
  },
}

custom_lsp.rust_analyzer = {
  on_attach = on_attach,
  settings = {
    ["rust-analyzer"] = {
      imports = {
        granularity = {
          group = "module",
        },
        prefix = "self",
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true,
      },
    },
  },
}

custom_lsp.yamlls = {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    yaml = {
      schemas = {
        ["https://raw.githubusercontent.com/quantumblacklabs/kedro/develop/static/jsonschema/kedro-catalog-0.17.json"] = "conf/**/*catalog*",
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
        ["https://raw.githubusercontent.com/SchemaStore/schemastore/master/src/schemas/json/traefik-v2-file-provider.json"] = "rules.yml",
        ["https://raw.githubusercontent.com/SchemaStore/schemastore/master/src/schemas/json/traefik-v2.json"] = "traefik.yml",
      },
    },
  },
}

custom_lsp.glslls = require("max.configs.lsp-glsl")

custom_lsp.ltex = {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    ltex = {
      language = "de",
      disabledRules = { ["en-US"] = { "PROFANITY" } },
      dictionary = {
        ["en-US"] = { "perf", "ci", "neovim" },
      },
      hiddenFalsePositives = {
        "neovim",
        "Neovim",
        "waybar",
      },
    },
  },
}

require('mason-lspconfig').setup_handlers({
  function(server_name)
    if custom_lsp[server_name] ~= nil then
      lsp[server_name].setup(custom_lsp[server_name])
    else
      lsp[server_name].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
    end
  end,
})
