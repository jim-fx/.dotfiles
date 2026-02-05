return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = nil, -- nothing preinstalled
      auto_install = true, -- install when buffer language is detected
      highlight = { enable = true },
    },
  },
}
