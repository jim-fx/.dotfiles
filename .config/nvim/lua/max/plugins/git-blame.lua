return {
  "f-person/git-blame.nvim",
  command = "GitBlameToggle",
  event = "BufReadPost",
  config = function()
    require('gitblame').setup {
      --Note how the `gitblame_` prefix is omitted in `setup`
      enabled = false,
    }
  end
}
