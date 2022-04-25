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

require("luasnip.loaders.from_vscode").load({ include = { "typescript", "javascript", "html" } })

-- Every unspecified option will be set to the default.
ls.config.set_config(
  {
  history = true,
  -- Update more often, :h events for more info.
  updateevents = "TextChanged,TextChangedI",
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "choiceNode", "Comment" } }
      }
    }
  },
  -- treesitter-hl has 100, use something higher (default is 200).
  ext_base_prio = 300,
  -- minimal increase in priority.
  ext_prio_increase = 1,
  enable_autosnippets = true
}
)

ls.add_snippets("all", {
  s({ trig = "b(%d)", regTrig = true, wordTrig = true }, {
    f(function(args) return { "Captured Text: " .. args[1].captures[1] .. "." } end, {}),
    i(0)
  })
})

ls.add_snippets("svelte", {
  s("slt", {
    t('<script lang="ts">', '\t'),
    i(0),
    t("</script>")
  }),
  s("sc", {
    t('<script context="module" lang="ts">', '\t'),
    i(0),
    t("</script>")
  })
})

ls.add_snippets("typescript", {
  s("sget", {
    t('export async function get({'),
    i(1, "params"),
    t("}) {"),
    i(2),
    t("}"),
  })
})
