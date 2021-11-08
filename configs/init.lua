require("install-packer")

local u = require("utils")

local o = vim.o
local g = vim.g
local cmd = vim.cmd

require ("plugins")

if u.has_plugin("cmp") then
  -- Global options
  o.number = true -- show line number
  o.tabstop = 2
  o.shiftwidth = 2 -- Indents will have a width of 4
  o.softtabstop = 2 -- Sets the number of columns for a TAB
  o.expandtab = false -- Dont expand TABs to spaces
  o.autoindent = true
	o.showmatch = true -- show matching brackets
	o.swapfile = false

  g.hidden = true --unload buffers when hidden
  g.filetype = true -- execute autocommands based on filetype

	cmd [[set mouse=a]] -- enable mouse interaction
  cmd [[set undofile]]
  cmd [[set fcs=eob:\ ]] --disable showing ~ in empty lines

	cmd [[command Format :lua vim.lsp.buf.formatting()]]
	
  cmd [[set noshowmode]] --to get rid of thing like --INSERT--
  cmd [[set noshowcmd]] --to get rid of display of last command
  cmd [[set shortmess+=F]] --to get rid of the file name displayed in the command line bar
	cmd [[set noruler]]

	g.ale_fixers = {"prettier", "eslint"}

	-- Enable Theming / Syntax
  o.syntax = "enable"
  o.termguicolors = true
	cmd("colorscheme material")
	g.material_terminal_italics = 1
	g.material_theme_style = "darker"
  -- Remove background color
  require("transparent").setup({enable = true})
  cmd("highlight Normal guibg=none")
  cmd("highlight NonText guibg=none")

	require('neoscroll').setup()
	
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
      arrow_open = " ",
      arrow_closed = " ",
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

  require("nvim-tree").setup {
    auto_open = 1,
    gitignore = 1,
    group_empty = 1,
		hijack_cursor = 1,
		update_focused_file = {
			enable = false,
		},
    diagnostics = {
			enable = true
		},
		view = {
			auto_resize = true,
			hide_root_folder = true,
      winopts = {
        signcolumn = "no"
      }
    }
  }
	require('nvim-tree.view').View.winopts.signcolumn = 'no'

	-- Configure Wiki
  g.wiki_root = "~/Notes"
  g.wiki_filetypes = {"md"}
  g.wiki_link_extension = ".md"
  
	  -- KeyBindings
  g.mapleader = " "
  require "keymappings"

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

  require'nvim-autopairs'.setup()

  -- Treesitter config
  require "treesitter-conf"

	-- Toggleterm / Lazygit setup
  require "lazy-git"


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

  -- Autocompletion Setup
  o.completeopt = "menuone,noselect,noinsert"
  require "autocomplete"

  -- LSP Config
  require "lspinstaller-conf"
	require "lsp-utils"

else
	vim.cmd[[PackerSync]]
end
