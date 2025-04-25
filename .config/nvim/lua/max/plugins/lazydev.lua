return {
  "folke/lazydev.nvim",
  ft = "lua", -- only load on lua files
  event = "VeryLazy",
  config = function()
    require("lazydev").setup({
      enabled = function(path)
        return path:find(vim.env.HOME .. "/.config/") ~= nil
      end,
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    })
    vim.lsp.enable("lua_ls")
  end,
}
