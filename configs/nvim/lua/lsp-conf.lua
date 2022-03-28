local lsp = require "lspconfig"
local lsp_status = require("lsp-status")
local ts_utils = require("nvim-lsp-ts-utils")

-- function to attach completion when setting up lsp
local function on_attach(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

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
lsp.grammar_guard.setup(
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

-- Typescript Language Server
lsp.tsserver.setup(
    {
        -- Needed for inlayHints. Merge this table with your settings or copy
        -- it from the source if you want to add your own init_options.
        init_options = require("nvim-lsp-ts-utils").init_options,
        --
        on_attach = function(client, bufnr)
            -- defaults
            ts_utils.setup(
                {
                    debug = true,
                    disable_commands = false,
                    enable_import_on_completion = false,
                    -- import all
                    import_all_timeout = 5000, -- ms
                    -- lower numbers = higher priority
                    import_all_priorities = {
                        same_file = 1, -- add to existing import statement
                        local_files = 2, -- git files or files with relative path markers
                        buffer_content = 3, -- loaded buffer content
                        buffers = 4 -- loaded buffer names
                    },
                    import_all_scan_buffers = 100,
                    import_all_select_source = false,
                    -- if false will avoid organizing imports
                    always_organize_imports = true,
                    -- filter diagnostics
                    filter_out_diagnostics_by_severity = {},
                    filter_out_diagnostics_by_code = {},
                    -- inlay hints
                    auto_inlay_hints = true,
                    inlay_hints_highlight = "Comment",
                    inlay_hints_priority = 200, -- priority of the hint extmarks
                    inlay_hints_throttle = 150, -- throttle the inlay hint request
                    inlay_hints_format = {
                        -- format options for individual hint kind
                        Type = {},
                        Parameter = {},
                        Enum = {}
                        -- Example format customization for `Type` kind:
                        -- Type = {
                        --     highlight = "Comment",
                        --     text = function(text)
                        --         return "->" .. text:sub(2)
                        --     end,
                        -- },
                    },
                    -- update imports on file move
                    update_imports_on_move = false,
                    require_confirmation_on_move = false,
                    watch_dir = nil
                }
            )

            -- required to fix code action ranges and filter diagnostics
            ts_utils.setup_client(client)

            -- no default maps, so you may want to define some here
            local opts = {silent = true}
            vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
            vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", opts)
            vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", opts)
        end
    }
)

-- JSON ls setup
lsp.jsonls.setup {
    on_attach = on_attach,
    capabilities = lsp_status.capabilities
}

-- JSON ls setup
lsp.cssls.setup {
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
