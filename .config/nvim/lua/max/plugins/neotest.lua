local function debug_nearest()
  require("neotest").run.run({ strategy = "dap" })
end

local function run_nearest()
  require('neotest').run.run()
end

local function open_summary()
  require('neotest').summary.open()
end

return {
  "nvim-neotest/neotest",
  cmd = "Neotest",
  keys = {
    { 'tr', debug_nearest, desc = 'Debug nearest test' },
    { "tt", run_nearest,   desc = "Run nearest test" },
    { "to", open_summary,  desc = "Open summary" },
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-vitest")({}),
        require("neotest-golang")({}),
        require("neotest-deno")({}),
        require("neotest-phpunit")({
          phpunit_cmd = function()
            return "bin/phpunit"
          end
        }),
      },
    })
  end,
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",

    -- Adapters
    "olimorris/neotest-phpunit",
    "KaiSpencer/neotest-vitest",
    "fredrikaverpil/neotest-golang",
    "MarkEmmons/neotest-deno"
  },
}
