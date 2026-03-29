return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  lazy = false,
  build = ":TSUpdate",
  opts_extend = {},
  setup = function()
    vim.treesitter.start()
  end,
  opts = {
    ensure_installed = {}, -- nothing preinstalled
    auto_install = true, -- install when buffer language is detected
    highlight = { enable = true },
  },
}
