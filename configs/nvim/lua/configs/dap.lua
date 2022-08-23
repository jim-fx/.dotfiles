local dap, dapui = require("dap"), require("dapui")

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

dap.adapters.firefox = {
  type = "executable",
  command = "node",
  options = {
    initialize_timeout_sec = 10,
    disconnect_timeout_sec = 10,
    max_retries = 30,
  },
  args = { os.getenv("HOME") .. "/.local/share/nvim/mason/packages/firefox-debug-adapter/dist/adapter.bundle.js" },
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
}
