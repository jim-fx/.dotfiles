return {
  "sam4llis/nvim-tundra",
  name = "tundra",
  config = function()
    require("nvim-tundra").setup({
      transparent_background = true,
      plugins = {
        lsp = true,
        treesitter = true,
        telescope = true,
        nvimtree = true,
        cmp = true,
        dbui = true,
        gitsigns = true,
      }
    })

    vim.opt.background = 'dark'
    vim.cmd('colorscheme tundra')
  end
}
