return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  config = function()
    vim.g.catppuccin_flavour = "frappe" -- latte, frappe, macchiato, mocha

    require("catppuccin").setup({
      transparent_background = true,
      compile = {
        enabled = true,
        path = vim.fn.stdpath("cache") .. "/catppuccin",
      },
      styles = {
        comments = { "italic" },
        strings = { "italic" },
      },
      integrations = {
        gitsigns = true,
        telescope = true,
        -- treesitter = true,
        cmp = true,
        lsp_saga = true,
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
    })

    vim.cmd("colorscheme catppuccin")
  end
} -- Enable Theming / Syntax
