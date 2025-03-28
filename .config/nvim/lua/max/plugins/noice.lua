return {
  "folke/noice.nvim",
  event = "VeryLazy",
  enabled = true,
  opts = {
    lsp = {
      progress = {
        enabled = false
      },
      hover = {
        enabled = false
      }
    },
    -- views = {
    --   cmdline_popup = {
    --     border = {
    --       style = "single",
    --       padding = { 0, 1 },
    --     },
    --     filter_options = {},
    --     win_options = {
    --       winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
    --     },
    --   },
    -- },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      lsp_doc_border = true
    },
  },
  keys = {
    {
      "<S-Enter>",
      function() require("noice").redirect(vim.fn.getcmdline()) end,
      mode = "c",
      desc =
      "Redirect Cmdline"
    },
    { "<leader>snl", function() require("noice").cmd("last") end,    desc = "Noice Last Message" },
    { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
    { "<leader>sna", function() require("noice").cmd("all") end,     desc = "Noice All" },
  },
}
