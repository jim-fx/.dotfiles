return {
  'saghen/blink.cmp',
  event = "InsertEnter",
  dependencies = {
    'rafamadriz/friendly-snippets',
    -- "fang2hou/blink-copilot",
    -- "zbirenbaum/copilot.lua",
    {
      "supermaven-inc/supermaven-nvim",
      opts = {
        disable_inline_completion = true, -- disables inline completion for use with cmp
        disable_keymaps = true            -- disables built in keymaps for more manual control
      }
    },
    {
      "huijiro/blink-cmp-supermaven"
    },
  },
  version = '1.*',
  config = function()
    -- require("copilot").setup({
    --   suggestion = { enabled = false },
    --   panel = { enabled = false },
    --   filetypes = {
    --     markdown = true,
    --     help = true,
    --   },
    -- })
    require("blink.cmp").setup({
      fuzzy = { implementation = "prefer_rust_with_warning" },
      keymap = {
        preset = 'enter',
        -- ["<Tab>"] = {
        --   function(cmp)
        --     if cmp.snippet_active() then
        --       return cmp.accept()
        --     else
        --       return cmp.select_and_accept()
        --     end
        --   end,
        --   "snippet_forward",
        --   "fallback",
        -- },
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' }
      },
      appearance = {
        nerd_font_variant = 'mono'
      },
      sources = {
        default = { 'lazydev', 'lsp', 'path', 'supermaven', 'snippets', 'buffer' },
        providers = {
          -- copilot = {
          --   name = "copilot",
          --   module = "blink-copilot",
          --   score_offset = 100,
          --   async = true,
          -- },
          supermaven = {
            name = 'supermaven',
            module = "blink-cmp-supermaven",
            async = true
          },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },
      completion = {
        list = {
          selection = {
            preselect = false
          }
        },
        ghost_text = {
          enabled = true,
          show_with_selection = true,
        },
        accept = {
          auto_brackets = {
            enabled = true
          }
        }
      }
    })
  end
}
