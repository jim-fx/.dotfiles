return {
  "nvim-neotest/neotest",
  cmd = "NeoTest",
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-vitest")({}),
      },
    })
  end,
  dependencies = {
    "haydenmeade/neotest-jest",
    "KaiSpencer/neotest-vitest",
  },
}
