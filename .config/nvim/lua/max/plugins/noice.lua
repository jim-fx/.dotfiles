return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  init = function()
    local initialWinborder = vim.o.winborder
    vim.api.nvim_create_autocmd("CmdlineEnter", {
      callback = function() vim.o.winborder = "none" end,
    })
    vim.api.nvim_create_autocmd("CmdlineLeave", {
      callback = function() vim.o.winborder = initialWinborder end,
    })
    require("noice").setup()
  end,
}
