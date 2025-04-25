local function debug_nearest()
  require("neotest").run.run({ strategy = "dap" })
end

return {
  "nvim-neotest/neotest",
  cmd = "Neotest",
  keys = {
    { '<leader>dr', debug_nearest, desc = 'Debug nearest test' },
  },
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

    -- Adapters
    "KaiSpencer/neotest-vitest",
    "fredrikaverpil/neotest-golang",
    "MarkEmmons/neotest-deno"
  },
}
