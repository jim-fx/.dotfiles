-- luasnip setup
local luasnip = require "luasnip"
local lspkind = require "lspkind"
local cmp = require "cmp"
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local compare = require('cmp.config.compare')

local source_mapping = {
  buffer = "[Buffer]",
  nvim_lsp = "[LSP]",
  nvim_lua = "[Lua]",
  cmp_tabnine = "[TN]",
  path = "[Path]",
}

local tabnine = require('cmp_tabnine.config')
tabnine:setup({
  max_lines = 1000;
  max_num_results = 20;
  sort = true;
  run_on_every_keystroke = true;
  snippet_placeholder = '..';
  ignored_file_types = { -- default is not to ignore
    -- uncomment to ignore in lua:
    -- lua = true
  };
  show_prediction_strength = false;
})

cmp.setup {
  -- formatting = {
  --     format = lspkind.cmp_format(
  --         {
  --             with_text = true,
  --             menu = ({
  --                 buffer = "[Buffer]",
  --                 nvim_lsp = "[LSP]",
  --                 luasnip = "[LuaSnip]",
  --                 nvim_lua = "[Lua]",
  --                 latex_symbols = "[Latex]"
  --             })
  --         }
  --     )
  -- },
  sorting = {
    priority_weight = 2,
    comparators = {
      require('cmp_tabnine.compare'),
      compare.offset,
      compare.exact,
      compare.score,
      compare.recently_used,
      compare.kind,
      compare.sort_text,
      compare.length,
      compare.order,
    },
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
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = lspkind.presets.default[vim_item.kind]
      local menu = source_mapping[entry.source.name]
      if entry.source.name == 'cmp_tabnine' then
        if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
          menu = entry.completion_item.data.detail .. ' ' .. menu
        end
        vim_item.kind = ''
      end
      vim_item.menu = menu
      return vim_item
    end
  },
  sources = {
    { name = "nvim_lua" },
    { name = "nvim_lsp" },
    { name = "cmp_tabnine" },
    { name = "luasnip" },
    { name = "path" },
    { name = "buffer" },
    { name = "calc" }
  }
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
  "/",
  {
    sources = {
      { name = "buffer" }
    }
  }
)

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
  ":",
  {
    sources = cmp.config.sources(
      {
        { name = "path" }
      },
      {
        { name = "cmdline" }
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

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
