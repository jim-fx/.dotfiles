local ls = require("luasnip")

-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node

local types = require("luasnip.util.types")

require("luasnip.loaders.from_vscode").load()

-- Every unspecified option will be set to the default.
ls.config.set_config({
  history = true,
  -- Update more often, :h events for more info.
  updateevents = "TextChanged,TextChangedI",
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "choiceNode", "Comment" } },
      },
    },
  },
  -- treesitter-hl has 100, use something higher (default is 200).
  ext_base_prio = 300,
  -- minimal increase in priority.
  ext_prio_increase = 1,
  enable_autosnippets = true,
})

ls.add_snippets("all", {
  s({ trig = "b(%d)", regTrig = true, wordTrig = true }, {
    f(function(args)
      return { "Captured Text: " .. args[1].captures[1] .. "." }
    end, {}),
    i(0),
  }),
})

local debugJSON = s("pcs", {
  t("<pre><code>{JSON.stringify("),
  i(0),
  t("null, 2)}</code></pre>"),
})

local function simple_restore(args, _)
  return sn(nil, { i(1, args[1]) })
end


ls.add_snippets('lua', {
  s(
    {
      trig = 'if',
      condition = function()
        local ignored_nodes = { 'string', 'comment' }

        local pos = vim.api.nvim_win_get_cursor(0)
        -- Use one column to the left of the cursor to avoid a "chunk" node
        -- type. Not sure what it is, but it seems to be at the end of lines in
        -- some cases.
        local row, col = pos[1] - 1, pos[2] - 1

        local node_type = vim.treesitter
            .get_node({
              pos = { row, col },
            })
            :type()

        return not vim.tbl_contains(ignored_nodes, node_type)
      end,
    },
    fmt(
      [[
if {} then
  {}
end
  ]],
      { i(1), i(2) }
    )
  ),
}, {
  type = 'autosnippets',
})

ls.add_snippets("svelte", {
  s("slt", {
    t({ '<script lang="ts">', "" }),
    i(0),
    t({ "", "</script>" }),
  }),
  s("sch", {
    t({
      '<script lang="ts">',
      ' import type { Hst } from "@histoire/plugin-svelte";',
      ' export let Hst: Hst;',
      ''
    }),
    t(" import "), i(1, "Component"), t(" from './"), d(2, simple_restore, 1), t({ ".svelte';", "" }),
    t({
      "</script>",
      "",
      "",
      "<Hst.Story>",
      ""
    }),
    t({ " <" }),
    d(3, simple_restore, 1),
    t({ " />", "" }),
    t({ ' <svelte:fragment slot="controls">', " </svelte:fragment>", "</Hst.Story>" }),
  }),
  s("sc", {
    t({ '<script context="module" lang="ts">', "" }),
    i(0),
    t({ "", "</script>" }),
  }),
  debugJSON,
})


ls.add_snippets("typescriptreact", {
  debugJSON,
})

ls.add_snippets("typescript", {
  debugJSON,
  s("sget", {
    t('export const GET: import("./$types").RequestHandler = async function get({'),
    i(1, "params"),
    t("}) {"),
    i(2),
    t("}"),
  }),
  s("spost", {
    t('export const POST: import("./$types").RequestHandler = async function get({'),
    i(1, "params"),
    t("}) {"),
    i(2),
    t("}"),
  }),
  s("ssess", {
    t({ "const {userId} = locals.session.data", "if(!userId) throw redirect(307, '/login')" }),
  }),
})
