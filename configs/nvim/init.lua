require("install-packer")

local u = require("utils")

local o = vim.o
local g = vim.g
local cmd = vim.cmd
local opt = vim.opt

require ("plugins")

if u.has_plugin("cmp") then

  vim.g.did_load_filetypes = 1

	-- Global options
	o.number = true -- show line number
	o.showmatch = true -- show matching brackets
	o.swapfile = false

	-- Indentation options
	vim.cmd [[
		set autoindent
		set expandtab
		set shiftwidth=2
		set softtabstop=2
		set tabstop=2
	]]

	-- Debug indentations
	if false then
		vim.cmd [[
			set list
			set listchars=eol:⏎,tab:->,trail:_,nbsp:⎵
		]]
	end

	g.hidden = true --unload buffers when hidden
	g.filetype = true -- execute autocommands based on filetype
	o.autoread = true

	o.lazyredraw = true

	-- Search
	o.inccommand = 'nosplit' -- show substitutions incrementally
	o.ignorecase = true
	o.smartcase = true
	opt.wildignore:append('.git/*', 'node_modules/*')
	o.wildignorecase = true
	o.lazyredraw = true

	opt.listchars:append({
		extends = "#",
		eol = '↴',
		space = '⋅',
		tab = '▸ ',
	})

	-- Shortmess
	cmd [[set shortmess+=F]]
	g.loaded_netrw = 1
	g.loaded_netrwPlugin = 1
	g.loaded_zipPlugin = 1
	g.loaded_zip = 1

	cmd [[set mouse=a]] -- enable mouse interaction
	cmd [[set undofile]]
	cmd [[set fcs=eob:\ ]] --disable showing ~ in empty lines

	cmd [[command Format :lua vim.lsp.buf.formatting()]]
	cmd [[command FormatSync :lua vim.lsp.buf.formatting_sync()]]
	
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

	-- Autocompletion Setup
	o.completeopt = "menuone,noselect,noinsert"
	require "autocomplete"
  require "snippets"

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

  -- Autocompletion Setup
  o.completeopt = "menuone,noselect,noinsert"
  require "autocomplete"

  -- LSP Config
  require "lspinstaller-conf"
	require "lsp-utils"

else
	vim.cmd[[PackerSync]]
end