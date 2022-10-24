-- Enable Theming / Syntax
vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha

local cat = require("catppuccin")
cat.setup({
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
    nvimtree = {
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

-- require("nightfox").setup({
--   options = {
--     transparent = true,
--   },
-- })

vim.cmd("colorscheme catppuccin")

require("utils.theme-reloader")
require("configs.lualine")
