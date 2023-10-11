return {
  "vlelo/arduino-helper.nvim",
  lazy = false,
  setup = function()
    vim.notify("Setup")
    require("arduino-helper").setup {
      ui = "telescope",
    }
  end
}
