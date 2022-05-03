local g = vim.g

-- Configure nvim-tree
g.nvim_tree_highlight_opened_files = 1
g.nvim_tree_group_empty = 1
g.nvim_tree_show_icons = {
  folder_arrows = 0,
  folders = 1,
  files = 1,
  git = 1
}
require("nvim-tree").setup {
  hijack_cursor = true,
  update_cwd = false,
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = ""
    }
  },
  view = {
    hide_root_folder = true,
    signcolumn = "no"
  }
}
