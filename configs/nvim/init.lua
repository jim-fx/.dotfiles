require("install-packer")

local u = require("utils")

local o = vim.o
local g = vim.g
local cmd = vim.cmd
local opt = vim.opt

require("plugins")

if u.has_plugin("cmp") then
    -- Global options
    o.number = true -- show line number
    o.showmatch = true -- show matching brackets

    -- Indentation options
    vim.cmd [[
      set autoindent
      set expandtab
      set shiftwidth=2
      set softtabstop=2
      set tabstop=1
    ]]

    g.hidden = true -- unload buffers when hidden
    g.filetype = true -- execute autocommands based on filetype
    o.autoread = true
    opt.termguicolors = true

    -- Search
    o.inccommand = "nosplit" -- show substitutions incrementally
    o.ignorecase = true
    o.smartcase = true
    opt.wildignore:append(".git/*", "node_modules/*")
    o.wildignorecase = true
    o.lazyredraw = true

    opt.listchars:append(
        {
            extends = "#",
            eol = "↴",
            space = "⋅",
            tab = "▸ "
        }
    )

    -- Shortmess
    cmd [[set shortmess+=F]]
    g.loaded_netrw = 1
    g.loaded_netrwPlugin = 1
    g.loaded_zipPlugin = 1
    g.loaded_zip = 1

    g.languagetool_server_jar = "~/build/languagetool/languagetool-server.jar"
    g.languagetool_lang = "de"

    cmd [[set mouse=a]] -- enable mouse interaction
    cmd [[set undofile]]
    cmd [[set fcs=eob:\ ]] -- disable showing ~ in empty lines

    cmd [[set noshowmode]] -- to get rid of thing like --INSERT--
    cmd [[set noshowcmd]] -- to get rid of display of last command
    cmd [[set shortmess+=F]] -- to get rid of the file name displayed in the command line bar

    cmd [[set noruler]]

    g.ale_fixers = {"prettier", "eslint"}

    vim.notify = require("notify")

    require("notify").setup(
        {
            stages = "fade_in_slide_out",
            render = "minimal",
            background_colour = "#000000",
            icons = {
                ERROR = "",
                WARN = "",
                INFO = "",
                DEBUG = "",
                TRACE = "✎"
            }
        }
    )

    require("telescope").setup {
        pickers = {
            find_files = {
                hidden = true
            }
        }
    }

    -- Enable Theming / Syntax
    o.syntax = "enable"
    o.termguicolors = true
    cmd("colorscheme nightfox")
    g.material_terminal_italics = 1
    g.material_theme_style = "darker"
    g.tokyonight_style = "night"
    g.tokyonight_transparent_sidebar = true
    require("nightfox").setup(
        {
            transparent = true
        }
    )

    require("transparent").setup(
        {
            enable = true,
            extra_groups = "All"
        }
    )

    -- Remove background color
    cmd("highlight Normal guibg=none")
    cmd("highlight NonText guibg=none")

    require("formatter-conf")

    -- Configure nvim-tree
    g.nvim_tree_special_files = {}
    g.nvim_tree_icons = {
        default = "",
        symlink = "",
        git = {
            unstaged = "*",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "★",
            deleted = "",
            ignored = "◌"
        },
        folder = {
            arrow_open = ">",
            arrow_closed = "<",
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
            symlink_open = ""
        },
        lsp = {
            hint = "",
            info = "",
            warning = "",
            error = ""
        }
    }

    g.nvim_tree_highlight_opened_files = 1
    g.nvim_tree_group_empty = 1
    g.nvim_tree_indent_markers = 0
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
        update_focused_file = {
            enable = false
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
            winopts = {
                signcolumn = "no"
            }
        }
    }
    require("nvim-tree.view").View.winopts.signcolumn = "no"

    -- Configure Wiki
    g.wiki_root = "~/Notes"
    g.wiki_filetypes = {"md"}
    g.wiki_link_extension = ".md"

    -- KeyBindings
    require "keymappings"

    require "overlays"

    require "nvim-tmux-navigation".setup {
        keybindings = {
            left = "<C-h>",
            down = "<C-j>",
            up = "<C-k>",
            right = "<C-l>",
            last_active = "<C-\\>",
            next = "<C-Space>"
        }
    }

    require "nvim-autopairs".setup()

    -- Treesitter config
    require "treesitter-conf"

    -- Autocompletion Setup
    require "snippets"
    require "cmp-conf"

    -- LSP Config
    require "lspinstaller-conf"
    require "lazy-git"

    require "autocommands"

    -- Setup rest.vim
    require("rest-nvim").setup(
        {
            -- Open request results in a horizontal split
            result_split_horizontal = false,
            -- Skip SSL verification, useful for unknown certificates
            skip_ssl_verification = false,
            -- Highlight request on run
            highlight = {
                enabled = true,
                timeout = 150
            },
            -- Jump to request line on run
            jump_to_request = false
        }
    )

    -- LSP Config
    require "lspinstaller-conf"
    require "lsp-conf"
else
    vim.cmd [[PackerSync]]
end
