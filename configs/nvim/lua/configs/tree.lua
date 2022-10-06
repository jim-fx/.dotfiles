-- Configure nvim-tree
require("nvim-tree").setup({
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
      error = "",
    },
  },
  view = {
    hide_root_folder = true,
    signcolumn = "no",
  },
  renderer = {
    group_empty = true,
    highlight_opened_files = "all",
    icons = {
      glyphs = {
        git = {
          untracked = "*",
        },
      },
      show = {
        folder_arrow = false,
        folder = true,
        file = true,
        git = true,
      },
    },
  },
})
