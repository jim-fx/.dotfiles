return {
  "romgrk/barbar.nvim",
  dependencies = 'nvim-tree/nvim-web-devicons',
  event = "VeryLazy",
  config = function()
    require("bufferline").setup({
      auto_hide = true,
      icons = {
        seperator = { left = "│", right = "" }
      }
    })
  end,
}
