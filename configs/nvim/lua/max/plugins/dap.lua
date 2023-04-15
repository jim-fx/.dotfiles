return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "mxsdev/nvim-dap-vscode-js",
  },
  config = function()
    require("max.configs.dap")

    local dap, dapui = require("dap"), require("dapui")

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open({})
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close({})
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close({})
    end

    require("dap-vscode-js").setup({
      -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
      -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
      -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
      adapters = { 'pwa-node', 'pwa-chrome' }, -- which adapters to register in nvim-dap
    })

    dap.adapters.node2 = {
      type = 'executable',
      command = 'node',
      args = { vim.fn.stdpath "data" .. '/mason/packages/node-debug2-adapter/out/src/nodeDebug.js' },
    }

    dap.adapters.firefox = {
      type = "executable",
      command = "node",
      options = {
        initialize_timeout_sec = 10,
        disconnect_timeout_sec = 10,
        max_retries = 30,
      },
      args = { vim.fn.stdpath("data") .. "/mason/packages/firefox-debug-adapter/dist/adapter.bundle.js" },
    }

    dap.configurations.typescript = {
      {
        name = "Debug with Firefox",
        type = "firefox",
        request = "launch",
        reAttach = true,
        webRoot = "${workspaceFolder}",
        url = "http://localhost:8080",
        firefoxExecutable = "/sbin/firefox-developer-edition",
      },
      {
        name = 'Launch',
        type = 'node2',
        request = 'launch',
        program = '${file}',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        console = 'integratedTerminal',
      },
      {
        -- For this to work you need to make sure the node process is started with the `--inspect` flag.
        name = 'Attach to process',
        type = 'node2',
        request = 'attach',
        sourceMaps = true,
        cwd = "${workspaceFolder}",
        processId = require 'dap.utils'.pick_process,
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach",
        processId = require 'dap.utils'.pick_process,
        cwd = "${workspaceFolder}",
      }
    }

    dap.configurations.typescriptreact = {
      {
        name = 'debug with firefox',
        type = 'firefox',
        request = 'launch',
        reattach = true,
        url = 'http://localhost:4200',
        webRoot = '/home/max/Projects/ruumio/main/apps/events-standalone/',
        firefoxExecutable = '/home/max/Downloads/firefox/firefox'
      },
      {
        name = 'debug with chrome',
        type = 'pwa-chrome',
        request = 'launch',
        reattach = true,
        url = 'http://localhost:4200',
        webroot = '${workspacefolder}',
        runtimeExecutable = '/mnt/c/Program Files/Google/Chrome/Application/chrome.exe'
      },
    }

    dap.configurations.javascript = dap.configurations.typescript;
  end,
}
