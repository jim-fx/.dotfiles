return {
  "folke/lazydev.nvim",
  ft = "lua", -- only load on lua files
  event = "VeryLazy",
  opts = {
enabled = function(path)
        return path:find(vim.env.HOME .. "/.config/") ~= nil
      end,
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
  }
}
