return {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    "arkav/lualine-lsp-progress",
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup {
      automatic_enable = true
    }

    vim.lsp.enable({
      "dartls",
      "denols",
      "glsl",
      "gopls",
      "html",
      "jsonls",
      "ltex",
      "ts_ls",
      "svelte",
      "lua_ls",
      "phpactor"
    })

    vim.diagnostic.config({
      source = true,
      virtual_text = { current_line = true },
      virtual_lines = false,
    })
  end,
}
