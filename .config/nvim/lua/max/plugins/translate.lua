return {
  "uga-rosa/translate.nvim",
  event = "InsertEnter",
  config = function()
    require("translate").setup({ default = { output = "replace" } })
  end,
}
