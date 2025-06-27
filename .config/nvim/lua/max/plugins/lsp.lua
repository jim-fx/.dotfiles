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
      automatic_enable = false
    }

    vim.lsp.config("denols", {
      root_markers = { "deno.json", "deno.jsonc", "deno.lock" },
      workspace_required = true,
    })

    vim.lsp.config("ts_ls", {
      root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json' },
      workspace_required = true,
    })

    vim.lsp.enable({
      "dartls",
      "denols",
      "glsl",
      "gopls",
      "html",
      "jsonls",
      "ltex",
      "ts_ls",
      "svelte"
    })


    vim.diagnostic.config({
      source = true,
      virtual_text = { current_line = true },
      virtual_lines = false,
    })
  end,
}
