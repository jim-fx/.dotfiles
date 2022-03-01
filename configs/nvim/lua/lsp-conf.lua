local lsp = require "lspconfig"
local lsp_status = require("lsp-status")

_G.lsp_organize_imports = function()
    local params = {
        command = "_typescript.organizeImports",
        arguments = {vim.api.nvim_buf_get_name(0)},
        title = ""
    }
    vim.lsp.buf.execute_command(params)
end

-- function to attach completion when setting up lsp
local function on_attach()
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    vim.cmd("command! LspOrganize lua lsp_organize_imports()")
    vim.api.nvim_buf_map(bufnr, "n", "gs", ":LspOrganize<CR>", {silent = true})
end

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

print(runtime_path)

require "lspconfig".sumneko_lua.setup {
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
                globals = {"vim"}
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

-- Ltex Language Server
require("grammar-guard").init()
-- setup LSP config
require("lspconfig").grammar_guard.setup(
    {
        cmd = {vim.fn.expand("~/.local/share/nvim/lsp_servers/ltex/ltex-ls/bin/ltex-ls")},
        settings = {
            ltex = {
                enabled = {"latex", "tex", "bib", "markdown"},
                language = "de",
                diagnosticSeverity = "information",
                additionalRules = {
                    enablePickyRules = true,
                    motherTongue = "de"
                },
                dictionary = {},
                disabledRules = {},
                hiddenFalsePositives = {}
            }
        }
    }
)

-- Go Language Server
lsp.gopls.setup {
    on_attach = on_attach,
    capabilities = lsp_status.capabilities
}

-- Html Setup
lsp.html.setup {
    on_attach = on_attach,
    capabilities = lsp_status.capabilities,
    filetypes = {"html"}
}

-- Svelte Language Server
lsp.svelte.setup {
    on_attach = on_attach,
    capabilities = lsp_status.capabilities
}

local function organize_imports()
    local params = {
        command = "_typescript.organizeImports",
        arguments = {vim.api.nvim_buf_get_name(0)},
        title = ""
    }
    vim.lsp.buf.execute_command(params)
end

-- Typescript Language Server
lsp.tsserver.setup {
    on_attach = on_attach,
    capabilities = lsp_status.capabilities,
    commands = {
        OrganizeImports = {
            organize_imports,
            description = "Organize Imports"
        }
    }
}

-- JSON ls setup
lsp.jsonls.setup {
    on_attach = on_attach,
    capabilities = lsp_status.capabilities
}

-- Setup diagnostics formaters and linters for non LSP provided files
lsp.diagnosticls.setup {
    on_attach = on_attach,
    capabilities = lsp_status.capabilities,
    cmd = {"diagnostic-languageserver", "--stdio"},
    filetypes = {
        "sh",
        "markdown",
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
