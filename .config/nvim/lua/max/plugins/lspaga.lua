return {
  'nvimdev/lspsaga.nvim',
  event = 'LspAttach',
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- optional
    'nvim-tree/nvim-web-devicons',     -- optional
  },
  config = function()
    require("lspsaga").setup({
      symbol_in_winbar = {
        enable = false
      },
      lightbulb = {
        enable = false
      },
    })

    vim.keymap.set({ "n", "v" }, "<Leader>c", ":Lspsaga code_action<CR>", { silent = true })
    vim.keymap.set({ "n", "v" }, "gr", ":Lspsaga finder<CR>", {})

    vim.keymap.set("n", "<Leader>io", ":Lspsaga outline<CR>", {})         -- [i]nspect [o]utline
    vim.keymap.set("n", "<Leader>ii", ":Lspsaga incomming_calls<CR>", {}) -- [i]nspect [i]ncomming_calls
    vim.keymap.set("n", "<Leader>io", ":Lspsaga outgoing_calls<CR>", {})  -- [i]nspect [o]utgoing_calls
  end
}
