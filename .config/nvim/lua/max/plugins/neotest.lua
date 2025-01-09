return {
  "nvim-neotest/neotest",
  cmd = "Neotest",
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-vitest")({}),
        require("neotest-golang")({}),
        require("neotest-deno")({}),
      },
    })
  end,
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",

    "haydenmeade/neotest-jest",
    "KaiSpencer/neotest-vitest",
    "fredrikaverpil/neotest-golang",
    "MarkEmmons/neotest-deno"
  },
}
