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
  dependencies = { 'rcarriga/nvim-dap-ui' },
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
    }

    vim.keymap.set('n', '<leader>dc', dapui.close, { desc = 'Dapui close' })
  end,
}
