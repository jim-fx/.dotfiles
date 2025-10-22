return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  config = function()
    vim.opt.foldenable = false;
    vim.opt.foldmethod = "expr";
    vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.opt.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
  build = ":TSUpdate",
}
