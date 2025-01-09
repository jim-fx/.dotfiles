return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  keys = {
    { "<leader>j", "<cmd>Neotree toggle<cr>",                   desc = "NeoTree" },
    { "<leader>f", "<cmd>Neotree action=focus reveal=true<CR>", desc = "NeoTree" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim"
  },
  init = function()
    vim.g.neo_tree_remove_legacy_commands = 1
    require("neo-tree").setup({
      hide_root_node = true,
      window = {
        mappings = {
          ["g"] = "git_add_file",
        }
      }
    })
  end,
}
