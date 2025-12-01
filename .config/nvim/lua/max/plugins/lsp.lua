return {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    "arkav/lualine-lsp-progress",
    "mason-org/mason.nvim",
  },
  config = function()
    require("mason").setup()

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
