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

require("luasnip.loaders.from_vscode").load({include = {"typescript", "javascript", "html"}}) -- Load only python snippets

-- Every unspecified option will be set to the default.
ls.config.set_config(
    {
        history = true,
        -- Update more often, :h events for more info.
        updateevents = "TextChanged,TextChangedI",
        ext_opts = {
            [types.choiceNode] = {
                active = {
                    virt_text = {{"choiceNode", "Comment"}}
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

ls.snippets = {
    all = {},
    svelte = {
        s(
            "slt",
            {
                t('<script lang="ts">'),
                i(0),
                t("</script>")
            }
        )
    }
}
