return {
  "andythigpen/nvim-coverage",
  requires = "nvim-lua/plenary.nvim",
  event = "VeryLazy",
  keys = {
    { "<Leader>ic", "<cmd>Coverage<CR>", desc = "Toggle Coverage" },
  },
  opts = {
    auto_reload = true,
  }
}
