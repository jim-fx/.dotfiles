return {
  'mfussenegger/nvim-dap',
  event = "VeryLazy",
  keys = {
    { '<F5>',       ':DapContinue<CR>',      desc = 'Debug continue' },
    {
      '<leader>db',
      '<cmd>DapToggleBreakpoint<CR>',
      desc = 'Debug toggle breakpoint',
    },
    { '<leader>do', '<cmd>DapStepOut<CR>',   desc = 'Debug step out' },
    { '<leader>dv', '<cmd>DapStepOver<CR>',  desc = 'Debug step over' },
    { '<leader>di', '<cmd>DapStepInto<CR>',  desc = 'Debug step into' },
    { '<leader>dt', '<cmd>DapTerminate<CR>', desc = 'Debug terminate' },
  },
  dependencies = {
    {
      'Nalum/nvim-dap-go',
      branch = "fix-remote-debug"
    },
    'daic0r/dap-helper.nvim',
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    -- {
    --   opt = true,
    --   "mxsdev/nvim-dap-vscode-js",
    --   run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
    -- }
  },
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')

    dapui.setup({
      layouts = {
        {
          position = "right",
          size = 40,
          elements = {
            {
              id = "scopes",
            },
            {
              id = "breakpoints",
              size = 0.2
            },
          },
        },
        --   {
        --   elements = { {
        --     id = "repl",
        --     size = 1
        --   } },
        --   position = "bottom",
        --   size = 8
        -- }
      },
    })

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
        args = { "/home/max/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}" },
      }
    }

    dap.adapters.dart = {
      type = "executable",
      command = "dart",
      args = { "debug_adapter" }
    }

    dap.adapters.php = {
      type = "executable",
      command = "node",
    }

    dap.configurations.dart = {
      {
        type = "dart",
        request = "launch",
        name = "Launch Dart Program",
        program = "${file}",
        cwd = "${workspaceFolder}",
        args = { "--help" }, -- Note for Dart apps this is args, for Flutter apps toolArgs
      }
    }

    dap.configurations.typescript = {
      {
        type = 'pwa-node',
        request = 'launch',
        name = "Deno: Launch debug task",
        runtimeExecutable = "deno",
        runtimeArgs = {
          "run",
          "--inspect-wait",
          "--allow-all",
          "--env-file",
          "main.ts",
        },
        cwd = "${workspaceFolder}",
        attachSimplePort = 9229,
      },
      {
        type = "pwa-node",
        name = "Deno: Attach to 9229",
        mode = "remote",
        port = 9229,
        request = "attach",
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Node: Attach",
        processId = require 'dap.utils'.pick_process,
        cwd = "${workspaceFolder}",
      }
    }

    require('dap-go').setup {
      dap_configurations = {
        {
          type = "go",
          name = "Go: Attach to Docker",
          mode = "remote",
          port = 4040,
          request = "attach",
          substitutePath = {
            {
              from = '${workspaceFolder}',
              to = '/app/backend'
            },
          },
        },
        {
          type = "go",
          name = "Go: Attach remote",
          mode = "remote",
          port = 4040,
          request = "attach",
        },
      },
    }

    vim.keymap.set('n', '<leader>dc', dapui.close, { desc = 'Debug Close' })

    require("dap-helper").setup()
  end,
}
