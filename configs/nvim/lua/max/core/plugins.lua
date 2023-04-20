local opts = {
  defaults = { lazy = true },
  install = { colorscheme = { require("max.plugins.theme").name } },
  change_detection = {
    enabled = true, -- automatically check for config file changes and reload the ui
    notify = true,  -- get a notification when changes are found
  },
  performance = {
    rtp = {
      reset = true,
    },
  }
}

require("lazy").setup("max.plugins", opts)
