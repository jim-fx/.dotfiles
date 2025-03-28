local opts = {
  defaults = { lazy = true },
  install = { colorscheme = { require("max.plugins.theme").name } },
  change_detection = {
    enabled = false
  },
}

require("lazy").setup("max.plugins", opts)
