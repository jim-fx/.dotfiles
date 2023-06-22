return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "arkav/lualine-lsp-progress",
    "williamboman/mason.nvim",
    "jose-elias-alvarez/null-ls.nvim",
    "williamboman/mason-lspconfig.nvim",
    "onsails/lspkind.nvim",
    "lukas-reineke/lsp-format.nvim"
  },
  event = "BufReadPost",
  config = function()
    local mason = require("mason")
    local mason_lsp = require("mason-lspconfig")
    local lsp = require("lspconfig")

    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
      vim.lsp.handlers.hover,
      { border = 'single' }
    )
    vim.diagnostic.config({
      float = {
        border = 'single',
      },
    })

    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.diagnostics.eslint_d,
      },
      should_attach = function()
        return lsp.util.root_pattern(".eslintrc", ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.yaml", ".eslintrc.json")(
          vim.fn.expand("%:p")) ~= nil;
      end,
    })

    mason.setup()
    mason_lsp.setup({
      ensure_installed = { "lua_ls", "jsonls", "tsserver", "svelte", "cssls", "prismals" },
    })

    local function on_attach(client)
      local active_clients = vim.lsp.get_active_clients()
      if client.name == 'denols' then
        for _, client_ in pairs(active_clients) do
          -- stop tsserver if denols is already active
          if client_.name == 'tsserver' then
            client_.stop()
          end
        end
      elseif client.name == 'tsserver' then
        for _, client_ in pairs(active_clients) do
          -- prevent tsserver from starting if denols is already active
          if client_.name == 'denols' then
            client.stop()
          end
        end
      end
      require("lsp-format").on_attach(client)
    end

    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    local custom_lsp = {}

    custom_lsp.tsserver = {
      root_dir = lsp.util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git"),
    }

    custom_lsp.denols = {
      root_dir = lsp.util.root_pattern("deno.json", "deno.jsonc"),
    }

    local runtime_path = vim.split(package.path, ";")
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")
    custom_lsp.lua_ls = {
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
            checkThirdParty = false
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },
    }

    custom_lsp.jsonls = {
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

    -- custom_lsp['arduino_language_server'] = {
    --   on_new_config = require("arduino").on_new_config,
    -- }

    -- custom_lsp.clangd = {
    --   cmd = { "clangd",
    --     "--query-driver=/home/max/.espressif/tools/xtensa-esp32-elf/esp-2020r3-8.4.0/**/bin/xtensa-esp32-elf-*" },
    --   root_dir = lsp.util.root_pattern('build/compile_commands.json', '.git'),
    -- }

    custom_lsp.rust_analyzer = {
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

    -- local glslls_config = require("max.configs.lsp-glsl")
    -- glslls_config.on_attach = on_attach;
    -- lsp.glslls.setup(glslls_config)

    custom_lsp.ltex = {
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

    mason_lsp.setup_handlers({
      function(server_name)
        local config = {
          on_attach = on_attach,
          capabilities = capabilities,
        }

        if custom_lsp[server_name] ~= nil then
          for k, v in pairs(custom_lsp[server_name]) do
            config[k] = v
          end
        end

        lsp[server_name].setup(config)
      end,
    })
  end,
}
