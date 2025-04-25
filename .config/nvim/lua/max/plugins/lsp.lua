return {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    "arkav/lualine-lsp-progress",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    require("mason").setup()

    vim.lsp.enable("tsserver")
    vim.lsp.enable("denols")
    vim.lsp.enable("gopls")
    vim.lsp.enable("jsonls")
    vim.lsp.enable("dartls")
    vim.lsp.enable("htmllsp")


    vim.diagnostic.config({
      virtual_text = { current_line = true },
      virtual_lines = false,
    })
  end,
}
