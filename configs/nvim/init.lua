require("utils.install-packer")

local u = require("utils")
require("core.plugins")

local g = vim.g
local cmd = vim.cmd

if u.has_plugin("cmp") then
  require "impatient"

  require "core.options"
  require "core.autocommands"
  require "core.keymappings"

  local packer = require("packer")

  -- Have packer use a popup window
  packer.init {
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  require "configs.command-center"
  require "configs.notify"
  require "configs.lsp"
  require "configs.lspinstaller"
  require "configs.telescope"
  require "configs.tree"

  -- Enable Theming / Syntax
  require("nightfox").setup({
    options = {
      transparent = true
    }
  })
  cmd("colorscheme nightfox")
  require "utils.theme-reloader"
  require "configs.lualine"

  -- Configure Wiki
  g.wiki_root = "~/Notes"
  g.wiki_filetypes = { "md" }
  g.wiki_link_extension = ".md"

  require "overlays"

  -- require "nvim-tmux-navigation".setup {
  --     keybindings = {
  --         left = "<C-h>",
  --         down = "<C-j>",
  --         up = "<C-k>",
  --         right = "<C-l>",
  --         last_active = "<C-\\>",
  --         next = "<C-Space>"
  --     }
  -- }

  require "nvim-autopairs".setup()

  -- Treesitter config
  require "configs.treesitter"

  -- Autocompletion Setup
  require "snippets"
  require "configs.autocomplete"

  -- Setup rest.vim
  -- require("rest-nvim").setup(
  --     {
  --         -- Open request results in a horizontal split
  --         result_split_horizontal = false,
  --         -- Skip SSL verification, useful for unknown certificates
  --         skip_ssl_verification = false,
  --         -- Highlight request on run
  --         highlight = {
  --             enabled = true,
  --             timeout = 150
  --         },
  --         -- Jump to request line on run
  --         jump_to_request = false
  --     }
  -- )

  -- LSP Config
  -- require "lsp-conf"
else
  vim.cmd [[PackerSync]]
  vim.cmd [[echo Installed -> Reload]]
end
