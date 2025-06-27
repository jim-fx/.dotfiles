-- Lua
return {
  "folke/persistence.nvim",
  lazy = false,
  config = function()
    require("persistence").setup({
      need = 1,
      branch = true,
    })
    require("persistence").load()
  end
}
