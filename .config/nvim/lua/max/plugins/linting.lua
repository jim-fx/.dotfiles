return {
  "mfussenegger/nvim-lint",
  event = "BufWritePre",
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      typescriptreact = { "eslint_d" },
    }
  end,
}
