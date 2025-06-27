return {
  'nvimdev/lspsaga.nvim',
  event = 'LspAttach',
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- optional
    'nvim-tree/nvim-web-devicons',     -- optional
  },
  keys = {
    { "<Leader>c", "<cmd>Lspsaga code_action<CR>",     desc = "Code Action" },
    { "gr", "<cmd>Lspsaga finder<CR>",          desc = "Finder" },
    { "<S-C-K>",    "<cmd>Lspsaga peek_definition<CR>", desc = "Definition" },
    { "<Leader>io", "<cmd>Lspsaga outline<CR>",         desc = "Outline" },
    { "<Leader>ii", "<cmd>Lspsaga incomming_calls<CR>", desc = "Incomming Calls" },
    { "<Leader>io", "<cmd>Lspsaga outgoing_calls<CR>",  desc = "Outgoing Calls" },
  },
  opts = {
    symbol_in_winbar = {
      enable = false
    },
    lightbulb = {
      enable = false,
    },
    finder = {
      keys = {
        vsplit = "<C-v>",
        split = "<C-x>",
      }
    },
  },
}
