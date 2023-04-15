-- local plugins = {
--
--   {
--     dir = "~/Projects/sudoku.nvim",
--     cmd = "Sudoku",
--     config = function()
--       require("sudoku").setup({
--         custom_highlights = {
--           square = { fg = "red" }
--         }
--       })
--       vim.cmd("hi SudokuSquare guibg=red")
--     end
--   },
--
--
--
--   {
--     "shortcuts/no-neck-pain.nvim",
--     cmd = "NoNeckPain",
--     config = true
--   },
--   ,
--   {
--     "stevearc/dressing.nvim",
--     enabled = false,
--     lazy = true,
--   },
--   {
--     "simrat39/symbols-outline.nvim",
--     cmd = "SymbolsOutline",
--     config = true,
--   },
--   ---------------------
--   -- Code Navigation --
--   ---------------------
--   ---------------
--   -- Lsp Setup --
--   ---------------
--   {
--     "glepnir/lspsaga.nvim",
--     event = "BufRead",
--     config = function()
--       require("lspsaga").setup({
--         symbol_in_winbar = {
--           enable = false,
--         },
--       })
--     end,
--   },
--   {
--     "folke/trouble.nvim",
--     cmd = "TroubleToggle",
--     dependencies = "nvim-tree/nvim-web-devicons",
--     config = function()
--       require("trouble").setup({})
--     end,
--   },
--   -------------------
--   --  Autocomplete --
--   -------------------
--   {
--     "nat-418/boole.nvim",
--     event = "InsertEnter",
--     config = function()
--       require("boole").setup({
--         mappings = {
--           increment = '+',
--           decrement = '-'
--         },
--         additions = {
--           { "const",    "let",      "var" },
--           { "absolute", "relative", "fixed", "sticky" }
--         }
--       })
--     end,
--   },
--   {
--     "gaoDean/autolist.nvim",
--     event = "InsertEnter",
--     config = true,
--   },
--   -------------------------
--   -- Syntax Highlighting --
--   -------------------------
--   {
--     "norcalli/nvim-colorizer.lua",
--     config = true,
--     event = "BufReadPost",
--   },
--   {
--     "folke/todo-comments.nvim",
--     config = true,
--     event = "VeryLazy",
--   },
--   --------------------
--   -- IDE Type Stuff --
--   --------------------
--   {
--     "rest-nvim/rest.nvim",
--     lazy = false,
--     dependencies = { "nvim-lua/plenary.nvim" },
--     config = function()
--       require("rest-nvim").setup({})
--     end,
--   },
--   {
--     "jackMort/ChatGPT.nvim",
--     cmd = "ChatGPT",
--     config = true,
--     dependencies = {
--       "MunifTanjim/nui.nvim",
--     },
--   },
--   --Dap Debugger -- Have not yet been able to set this up
-- }

local opts = {
  defaults = { lazy = true },
  install = { colorscheme = { require("max.plugins.theme").name } },
  change_detection = {
    enabled = true, -- automatically check for config file changes and reload the ui
    notify = true,  -- get a notification when changes are found
  },
  performance = {
    rtp = {
      reset = true,
      disabled_plugins = {
        "gzip",
        "zip",
        "zipPlugin",
        "fzf",
        "tar",
        "tarPlugin",
        "getscript",
        "getscriptPlugin",
        "vimball",
        "vimballPlugin",
        "2html_plugin",
        "matchit",
        "matchparen",
        "logiPat",
        "rrhelper",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
      },
    },
  }
}

require("lazy").setup("max.plugins", opts)
