return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-dap.nvim",
    "nvim-telescope/telescope-fzf-native.nvim",
    "debugloop/telescope-undo.nvim",
  },
  event = "VeryLazy",
  keys = {
    {
      "<C-o>",
      function()
        require "telescope.builtin".find_files({ hidden = vim.g.show_hidden })
      end,
      desc = "Find files",
    },
    {
      "<C-f>",
      "<cmd>Telescope live_grep<CR>",
      desc = "Live grep"
    },
    {
      "<Leader-o>",
      "<cmd>Telescope buffers<CR>",
      desc = "Find buffers"
    },
    {
      "<Leader>ts",
      "<cmd>Telescope git_branches<CR>",
      desc = "Switch Git branches"
    },
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      defaults = {},
    })

    local function open_with_trouble()
      require("trouble.providers.telescope").open_with_trouble()
    end

    local default = {
      extensions = {
        sessions_picker = {
          sessions_dir = vim.fn.stdpath("data") .. "/sessions/",
        },
      },
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--ignore-file",
          ".gitignore",
        },
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = { "node_modules", "*pnpm-lock*" },
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        winblend = 0,
        mappings = {
          i = { ["<c-t>"] = open_with_trouble },
          n = { ["<c-t>"] = open_with_trouble },
        },
        color_devicons = true,
        use_less = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      },
    }

    telescope.setup(default)


    telescope.load_extension("notify")
    telescope.load_extension("undo")
    telescope.load_extension("git_worktree")
  end,
}
