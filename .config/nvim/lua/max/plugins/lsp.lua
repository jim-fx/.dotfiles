return {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    "arkav/lualine-lsp-progress",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "barreiroleo/ltex_extra.nvim",
  },
  config = function()
    require("mason").setup()

    local capabilities = require('blink.cmp').get_lsp_capabilities()

    vim.lsp.config["lua-language-server"] = {
      capabilities = capabilities,
      cmd = { "lua-language-server" },
      root_markers = { ".luarc.json" },
      filetypes = { "lua" },
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
            path = vim.split(package.path, ";")
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false
          },
          telemetry = {
            enable = false,
          },
        },
      },
    }
    vim.lsp.enable("lua-language-server")

    vim.lsp.config.tsserver = {
      cmd = { "typescript-language-server", "--stdio" },
      filetypes = { "typescript", "typescriptreact" },
      capabilities = capabilities,
      root_markers = { "tsconfig.json", "package.json", "jsconfig.json", ".git" },
    }
    vim.lsp.enable("tsserver")

    vim.lsp.config.denols = {
      cmd = { "deno", "lps" },
      filetypes = { "typescript" },
      capabilities = capabilities,
      root_markers = { "deno.json", "deno.jsonc", "deno.lock" },
    }
    vim.lsp.enable("denols")

    vim.lsp.config.gopls = {
      cmd = { "gopls" },
      capabilities = capabilities,
      filetypes = { "go" },
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
        },
      },
    }
    vim.lsp.enable("gopls")

    vim.lsp.config.jsonls = {
      cmd = { "vscode-json-language-server" },
      filetypes = { "json" },
    }
    vim.lsp.enable("jsonls")

    -- Configure diagnostics
    vim.diagnostic.config({
      virtual_text = { current_line = true },
      virtual_lines = true,
    })
  end,
}
