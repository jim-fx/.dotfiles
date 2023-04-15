return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim"
  },
  init = function()
    vim.g.neo_tree_remove_legacy_commands = 1
    require("neo-tree").setup({
      hide_root_node = true,
    })
  end,
}
