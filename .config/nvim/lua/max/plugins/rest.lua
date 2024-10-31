return {
  "rest-nvim/rest.nvim",
  ft = { "http" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    ---@type rest.Opts
    vim.g.rest_nvim = {
      _log_level = vim.log.levels.DEBUG
    }
  end,
}
