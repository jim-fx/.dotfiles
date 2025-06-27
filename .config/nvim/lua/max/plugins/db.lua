return {
  "kndndrj/nvim-dbee",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  keys = {
    {
      "<leader>dd",
      function()
        require("dbee").toggle()
      end,
      desc = "Toggle Database Explorer",
    },
  },
  build = function()
    require("dbee").install()
  end,
  config = function()
    require("dbee").setup({})
  end,
}
