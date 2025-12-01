return {
  'saghen/blink.cmp',
  event = "InsertEnter",
  dependencies = {
    'rafamadriz/friendly-snippets',
    "junkblocker/blink-cmp-wezterm",
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
  opts = {
    fuzzy = { implementation = "prefer_rust_with_warning" },
    keymap = {
      preset = 'enter',
      ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<C-j>'] = { 'select_next', 'fallback' }
    },
    appearance = {
      nerd_font_variant = 'mono'
    },
    sources = {
      default = { 'lazydev', 'lsp', 'path', 'supermaven', 'snippets', 'buffer', 'wezterm' },
      providers = {
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
        wezterm = {
          module = "blink-cmp-wezterm",
          name = "wezterm",
          score_offset = -50,
          opts = {
            all_panes = false,
            capture_history = false,
          },
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
  }
}
