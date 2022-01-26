-- luasnip setup
local cmd = vim.cmd
local luasnip = require "luasnip"
local lspkind = require "lspkind"
local cmp = require "cmp"
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

cmp.setup {
    formatting = {
        format = lspkind.cmp_format(
            {
                with_text = true,
                menu = ({
                    buffer = "[Buffer]",
                    nvim_lsp = "[LSP]",
                    luasnip = "[LuaSnip]",
                    nvim_lua = "[Lua]",
                    latex_symbols = "[Latex]"
                })
            }
        )
    },
    experimental = {
        ghost_text = true
    },
    completion = {
        completeopt = "menu,menuone"
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    mapping = {
        ["<C-Leader>"] = cmp.mapping.complete(),
        ["<Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end,
        ["<CR>"] = cmp.mapping.confirm(
            {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true
            }
        )
    },
    sources = {
        {name = "nvim_lua"},
        {name = "nvim_lsp"},
        {name = "luasnip"},
        {name = "path"},
        {name = "buffer"},
        {name = "calc"}
    }
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
    "/",
    {
        sources = {
            {name = "buffer"}
        }
    }
)

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
    ":",
    {
        sources = cmp.config.sources(
            {
                {name = "path"}
            },
            {
                {name = "cmdline"}
            }
        )
    }
)

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
require "lspconfig".html.setup {
    capabilities = capabilities
}

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({map_char = {tex = ""}}))
