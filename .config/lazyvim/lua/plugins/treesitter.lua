return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  opts_extend = {},
  opts = {
    ensure_installed = {}, -- nothing preinstalled
    auto_install = true, -- install when buffer language is detected
    highlight = { enable = true },
  },
}
