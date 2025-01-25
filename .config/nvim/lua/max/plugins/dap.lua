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
    'leoluz/nvim-dap-go',
    'daic0r/dap-helper.nvim',
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    {
      opt = true,
      "mxsdev/nvim-dap-vscode-js",
      run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
    }
  },
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')

    dapui.setup({
      layouts = { {
        elements = { {
          id = "scopes",
        }, {
          id = "breakpoints",
          size = 8 / vim.api.nvim_win_get_width(0)
        },
        },
        position = "left",
        size = 40
      }, {
        elements = { {
          id = "repl",
          size = 1
        } },
        position = "bottom",
        size = 8
      }
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
        processId = require 'dap.utils'.pick_process,
        cwd = "${workspaceFolder}",
      }
    }

    require('dap-go').setup {
      dap_configurations = {
        {
          type = "go",
          name = "Attach to Docker :4040",
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
          name = "Attach to :4040",
          mode = "remote",
          port = 4040,
          request = "attach",
        },
        {
          type = "go",
          name = "Debug go run main.go sp cache",
          request = "launch",
          program = "${workspaceFolder}/main.go",
          args = { "sp", "cache" },
          console = "integratedTerminal",
        },
      },
    }

    dap.set_log_level("TRACE")
    require("telescope").load_extension('dap')
    vim.keymap.set('n', '<leader>dc', dapui.close, { desc = 'Debug Close' })
    vim.keymap.set('n', '<leader>dd', "<cmd>Telescope dap configurations<CR>", { desc = 'Debug Start' })

    require("dap-helper").setup()
  end,
}
