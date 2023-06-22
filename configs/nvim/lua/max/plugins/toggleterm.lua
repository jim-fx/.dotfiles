return {
  "akinsho/nvim-toggleterm.lua",
  event = "VeryLazy",
  config = function()
    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      direction = "float",
      float_opts = {
        winblend = 0,
        border = "shadow",
      },
      on_close = function()
        Terminal:close()
      end,
    })

    function _Lazygit_toggle()
      lazygit:toggle()
    end

    vim.api.nvim_set_keymap("n", "<C-g>", "<cmd>lua _Lazygit_toggle()<CR>", { noremap = true, silent = true })



    local arduinoMonitor = Terminal:new({
      cmd = "arduino-cli monitor -p /dev/ttyUSB0",
      direction = "horizontal",
      float_opts = {
        winblend = 0,
        padding = 10,
        border = "single",
      },
      on_close = function()
        Terminal:close()
      end,
    })
    vim.api.nvim_create_user_command("ArduinoMonitor", function()
      arduinoMonitor:toggle()
    end, {})

    local arduinoUpload = Terminal:new({
      cmd = "arduino-cli compile --upload",
      direction = "horizontal",
      float_opts = {
        winblend = 0,
        padding = 10,
        border = "single",
      },
      on_close = function()
        Terminal:close()
      end,
    })
    vim.api.nvim_create_user_command("ArduinoUpload", function()
      arduinoUpload:toggle()
    end, {})


    local pnpm = Terminal:new({
      dir = "git_dir",
      direction = "float",
      float_opts = {
        winblend = 0,
        padding = 10,
        border = "single",
      },
      on_close = function()
        Terminal:close()
      end,
    })

    function _Pnpm_toggle()
      pnpm:toggle()
    end

    vim.api.nvim_set_keymap("n", "<C-t>", "<cmd>lua _Pnpm_toggle()<CR>", { noremap = true, silent = true })
  end,
}
