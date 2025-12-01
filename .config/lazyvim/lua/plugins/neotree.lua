return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  keys = {
    {
      "<leader>fe",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
      end,
      desc = "Explorer NeoTree (Root Dir)",
    },
    {
      "<leader>fE",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
      end,
      desc = "Explorer NeoTree (cwd)",
    },
    { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (Root Dir)", remap = true },
    { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)",      remap = true },
    {
      "<leader>ge",
      function()
        require("neo-tree.command").execute({ source = "git_status", toggle = true })
      end,
      desc = "Git Explorer",
    },
    {
      "<leader>be",
      function()
        require("neo-tree.command").execute({ source = "buffers", toggle = true })
      end,
      desc = "Buffer Explorer",
    },
  },
  deactivate = function()
    vim.cmd([[Neotree close]])
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim"
  },
  opts = {
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
          require("neo-tree.sources.filesystem")._navigate_internal(state, nil, nil, nil, false)
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
  }
}

