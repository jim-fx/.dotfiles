local nvim_lsp = require "lspconfig"
local lsp_status = require("lsp-status")

-- function to attach completion when setting up lsp
local function on_attach(client)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  local opts = {noremap = true, silent = true}
  buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
  buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
            augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            " autocmd CursorHold *.* :lua vim.lsp.diagnostic.show_line_diagnostics()
            autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 300)
           augroup END
        ]],
      false
    )
  end
end
-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local servers = {
  "tsserver",
  "svelte"
}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = lsp_status.capabilities
  }
end

-- Setup diagnostics formaters and linters for non LSP provided files
nvim_lsp.diagnosticls.setup {
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
  cmd = {"diagnostic-languageserver", "--stdio"},
  filetypes = {
    "lua",
    "sh",
    "markdown",
    "json",
    "yaml",
    "toml"
  },
  init_options = {
    linters = {
      shellcheck = {
        command = "shellcheck",
        debounce = 100,
        args = {"--format", "json", "-"},
        sourceName = "shellcheck",
        parseJson = {
          line = "line",
          column = "column",
          endLine = "endLine",
          endColumn = "endColumn",
          message = "${message} [${code}]",
          security = "level"
        },
        securities = {
          error = "error",
          warning = "warning",
          info = "info",
          style = "hint"
        }
      },
      markdownlint = {
        command = "markdownlint",
        isStderr = true,
        debounce = 100,
        args = {"--stdin"},
        offsetLine = 0,
        offsetColumn = 0,
        sourceName = "markdownlint",
        formatLines = 1,
        formatPattern = {
          "^.*?:\\s?(\\d+)(:(\\d+)?)?\\s(MD\\d{3}\\/[A-Za-z0-9-/]+)\\s(.*)$",
          {
            line = 1,
            column = 3,
            message = {4}
          }
        }
      }
    },
    filetypes = {
      sh = "shellcheck",
      markdown = "markdownlint"
    },
    formatters = {
      shfmt = {
        command = "shfmt",
        args = {"-i", "2", "-bn", "-ci", "-sr"}
      },
      prettier = {
        command = "prettier",
        args = {"--stdin-filepath", "%filepath"}
      }
    },
    formatFiletypes = {
      sh = "shfmt",
      json = "prettier",
      yaml = "prettier",
      toml = "prettier",
      markdown = "prettier",
      lua = "prettier"
    }
  }
}

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    underline = true,
    virtual_text = false,
    signs = true,
    update_in_insert = true
  }
)
local lsp_status = require("lsp-status")

-- function to attach completion when setting up lsp
local function on_attach(client)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  local opts = {noremap = true, silent = true}
  buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
  buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
            augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            " autocmd CursorHold *.* :lua vim.lsp.diagnostic.show_line_diagnostics()
            autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 300)
           augroup END
        ]],
      false
    )
  end
end
-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local servers = {
  "tsserver",
  "svelte"
}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = lsp_status.capabilities
  }
end

-- Setup diagnostics formaters and linters for non LSP provided files
nvim_lsp.diagnosticls.setup {
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
  cmd = {"diagnostic-languageserver", "--stdio"},
  filetypes = {
    "lua",
    "sh",
    "markdown",
    "json",
    "yaml",
    "toml"
  },
  init_options = {
    linters = {
      shellcheck = {
        command = "shellcheck",
        debounce = 100,
        args = {"--format", "json", "-"},
        sourceName = "shellcheck",
        parseJson = {
          line = "line",
          column = "column",
          endLine = "endLine",
          endColumn = "endColumn",
          message = "${message} [${code}]",
          security = "level"
        },
        securities = {
          error = "error",
          warning = "warning",
          info = "info",
          style = "hint"
        }
      },
      markdownlint = {
        command = "markdownlint",
        isStderr = true,
        debounce = 100,
        args = {"--stdin"},
        offsetLine = 0,
        offsetColumn = 0,
        sourceName = "markdownlint",
        formatLines = 1,
        formatPattern = {
          "^.*?:\\s?(\\d+)(:(\\d+)?)?\\s(MD\\d{3}\\/[A-Za-z0-9-/]+)\\s(.*)$",
          {
            line = 1,
            column = 3,
            message = {4}
          }
        }
      }
    },
    filetypes = {
      sh = "shellcheck",
      markdown = "markdownlint"
    },
    formatters = {
      shfmt = {
        command = "shfmt",
        args = {"-i", "2", "-bn", "-ci", "-sr"}
      },
      prettier = {
        command = "prettier",
        args = {"--stdin-filepath", "%filepath"}
      }
    },
    formatFiletypes = {
      sh = "shfmt",
      json = "prettier",
      yaml = "prettier",
      toml = "prettier",
      markdown = "prettier",
      lua = "prettier"
    }
  }
}

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    underline = true,
    virtual_text = false,
    signs = true,
    update_in_insert = true
  }
)

