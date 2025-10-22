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
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",

    -- Adapters
    "olimorris/neotest-phpunit",
    "KaiSpencer/neotest-vitest",
    "MarkEmmons/neotest-deno",
    {
      "fredrikaverpil/neotest-golang",
      version = "*",
      build = function()
        vim.system({ "go", "install", "gotest.tools/gotestsum@latest" }):wait()
      end,
    },
  },
  keys = {
    { 'tr', debug_nearest, desc = 'Debug nearest test' },
    { "tt", run_nearest,   desc = "Run nearest test" },
    { "to", open_summary,  desc = "Open summary" },
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-vitest")({}),
        require("neotest-golang")({
          runner = "gotestsum",
        }),
        require("neotest-deno")({}),
        require("neotest-phpunit")({
          filter_dirs = { "vendor" },
          phpunit_cmd = function()
            return "bin/phpunit"
          end
        }),
      },
    })
  end,
}
