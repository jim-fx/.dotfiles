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
          ["o"] = "custom_open",
        }
      },
      filesystem = {
        commands = {
          custom_open = function(state)
            local path = state.tree:get_node().path
            vim.system({ "xdg-open", vim.fn.fnameescape(path) }, { detach = true })
          end,
          -- Override delete to use trash instead of rm
          delete = function(state)
            local path = state.tree:get_node().path
            vim.system({ "trash", vim.fn.fnameescape(path) })
            require("neo-tree.sources.manager").refresh(state.name)
          end,
        },
      },
    })
  end,
}
