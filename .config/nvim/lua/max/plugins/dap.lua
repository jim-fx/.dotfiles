return {
  'mfussenegger/nvim-dap',
  keys = {
    { '<F5>',       ':DapContinue<CR>',  desc = 'Debug continue' },
    {
      '<leader>db',
      ':DapToggleBreakpoint<CR>',
      desc = 'Debug toggle breakpoint',
    },
    { '<leader>do', ':DapStepOut<CR>',   desc = 'Debug step out' },
    { '<leader>dv', ':DapStepOver<CR>',  desc = 'Debug step over' },
    { '<leader>di', ':DapStepInto<CR>',  desc = 'Debug step into' },
    { '<leader>dt', ':DapTerminate<CR>', desc = 'Debug terminate' },
  },
  dependencies = { 'rcarriga/nvim-dap-ui','nvim-neotest/nvim-nio', {
"mxsdev/nvim-dap-vscode-js",
    opt = true,
 run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
}
  },
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')
    local utils = require('dap.utils')

    -- Add listeners to automatically open and close dapui
    dapui.setup()

    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open({})
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close({})
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close({})
    end

    require("dap-vscode-js").setup({
  -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
  -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
  adapters = { 'pwa-node'}, -- which adapters to register in nvim-dap
  -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
  -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
  -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})


    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        args = { "/home/max/.local/bin/js-debug/src/dapDebugServer.js", "${port}" },
      }
    }

    dap.configurations.typescript = {
      {
        type = 'pwa-node',
        request = 'launch',
        name = "Launch debug task",
        runtimeExecutable = "deno",
        runtimeArgs = {
          "task",
          "debug",
        },
        cwd = "${workspaceFolder}",
        attachSimplePort = 9229,
      },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require'dap.utils'.pick_process,
          cwd = "${workspaceFolder}",
        }
    }

    vim.keymap.set('n', '<leader>dc', dapui.close, { desc = 'Dapui close' })
  end,
}
