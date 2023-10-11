return {
  "Shatur/neovim-ayu",
  lazy = false,
  name = "ayu",
  config = function()
    require('ayu').setup({
      mirage = false, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
      overrides = {
        normal = { bg = "NONE" },
      }
    })
    vim.cmd("hi Normal guibg=none")
    vim.cmd("colorscheme ayu")
    vim.cmd("hi Normal guibg=none")
  end
}
