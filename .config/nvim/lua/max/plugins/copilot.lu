return {
  "copilotlsp-nvim/copilot-lsp",
  -- lazy = false,
  enabled = false,
  enable = false,
  init = function()
    vim.notify("copilot init")
    vim.g.copilot_nes_debounce = 500
    vim.lsp.enable("copilot")
    vim.keymap.set("n", "<tab>", function()
      require("copilot-lsp.nes").apply_pending_nes()
    end)
  end,
}
