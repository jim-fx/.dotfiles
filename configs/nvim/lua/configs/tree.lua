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
    auto_open = 1,
    gitignore = 1,
    group_empty = 1,
    hijack_cursor = 1,
    update_cwd = true,
    update_focused_file = {
        enable = false
    },
    renderer = {
      indent_markers = {
        enable = 0
      }
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
        auto_resize = true,
        hide_root_folder = true,
        signcolumn = "no"
    }
}
