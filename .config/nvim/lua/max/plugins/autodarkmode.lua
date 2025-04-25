return {
  "f-person/auto-dark-mode.nvim",
  lazy = false,
  config = function()
    require('auto-dark-mode').setup({
      update_interval = 2000,
      set_dark_mode = function()
        vim.api.nvim_set_option_value('background', 'dark', { scope = "global" })
        vim.cmd('colorscheme catppuccin-mocha')
      end,
      set_light_mode = function()
        vim.api.nvim_set_option_value('background', 'light', { scope = "global" })
        vim.cmd('colorscheme catppuccin-latte')
      end,
    })
  end
}
