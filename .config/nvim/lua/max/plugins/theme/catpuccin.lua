return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  opts = {
    transparent_background = true,
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    term_colors = true,
    compile = {
      enabled = true,
      path = vim.fn.stdpath("cache") .. "/catppuccin",
    },
    styles = {
      comments = { "italic" },
    },
    custom_highlights = function()
      return {
        Folded = { bg = "#1d1e27" },
        BlinkCmpMenu = { bg = "#000000" },
        BlinkCmpMenuBorder = { bg = "#000000" }
      }
    end,
    integrations = {
      gitsigns = true,
      telescope = true,
      bufferline = true,
      treesitter = true,
      blink_cmp = true,
      notify = true,
      neotree = {
        enabled = true,
        show_root = false,
      },
      dap = {
        enabled = true,
        enable_ui = true,
      },
      native_lsp = {
        enabled = true,
      },
      ts_rainbow = true,
      indent_blankline = {
        enabled = true,
        colored_indent_levels = false,
      },
    },
  }
}
