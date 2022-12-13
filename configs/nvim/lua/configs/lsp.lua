local mason = require("mason")
local mason_lsp = require("mason-lspconfig")
local lsp = require("lspconfig")

require("null-ls").setup({
  sources = {
    require("null-ls").builtins.formatting.stylua,
    require("null-ls").builtins.diagnostics.eslint,
    require("null-ls").builtins.completion.spell,
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
  local cap = client.server_capabilities

  if cap.documentFormattingProvider then
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

lsp.sumneko_lua.setup({
  on_attach = on_attach,
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
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true

lsp.prismals.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lsp.emmet_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lsp.solargraph.setup({
  filetypes = { "ruby" },
  on_attach = on_attach,
})

lsp.elixirls.setup({
  on_attach = on_attach,
})

lsp.jsonls.setup({
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
      },
    },
  },
})

lsp.svelte.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
lsp.tsserver.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
lsp.html.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
lsp.phpactor.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
lsp.intelephense.setup({
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
})
lsp.cssls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lsp.zls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lsp.bashls.setup({
  capabilities = capabilities,
  filetypes = { "sh", "bash" },
  on_attach = on_attach,
})

lsp.rust_analyzer.setup({
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
})

lsp.gopls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lsp.yamlls.setup({
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
})

lsp.glslls.setup(require("configs.lsp-glsl"))

lsp.ltex.setup({
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
})
