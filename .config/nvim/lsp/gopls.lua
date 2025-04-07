return {
  cmd = { "gopls" },
  filetypes = { "go" },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}
