-- Enable Theming / Syntax
require("nightfox").setup({
  options = {
    transparent = true
  }
})
vim.cmd("colorscheme nightfox")
require "utils.theme-reloader"
require "configs.lualine"
