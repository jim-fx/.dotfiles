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
  config = function()
    local fs = require("neo-tree.sources.filesystem")
    require("neo-tree").setup({
      hide_root_node = true,
      window = {
        mappings = {
          ["g"] = "git_add_file",
          ["o"] = "custom_open",
          ["<C-v>"] = "open_vsplit",
          ["<C-x>"] = "open_split",
          ["<C-f>"] = nil,
          ["H"] = "custom_toggle"
        }
      },
      filesystem = {
        commands = {
          custom_toggle = function(state)
            state.filtered_items.visible = not state.filtered_items.visible
            vim.g.show_hidden = state.filtered_items.visible
            fs._navigate_internal(state, nil, nil, nil, false)
          end,
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
