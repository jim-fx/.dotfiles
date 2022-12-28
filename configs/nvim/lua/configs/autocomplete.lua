-- luasnip setup
local luasnip = require("luasnip")

local lspkind = require("lspkind")
local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

local capabilities = require("cmp_nvim_lsp").default_capabilities()
require("lspconfig").html.setup({
  capabilities = capabilities,
})

require("nvim-autopairs").setup()
require("copilot").setup()
require("copilot_cmp").setup({
  clear_after_cursor = true,
})

cmp.setup({
  window = {
    documentation = cmp.config.window.bordered(),
  },
  experimental = {
    ghost_text = true,
  },
  completion = {
    completeopt = "menu,menuone,noselect",
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-Leader>"] = cmp.mapping.complete({}),
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
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol_text",
      max_width = 50,
      symbol_map = { Copilot = "" },
    }),
  },
  sources = {
    { name = "copilot" },
    { name = "vim-dadbod-completion", filetype = "sql" },
    { name = "nvim_lua" },
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "emoji" },
    { name = "path" },
    { name = "buffer" },
    { name = "buffer" },
    { name = "calc" },
  },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
  sources = {
    { name = "buffer" },
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
