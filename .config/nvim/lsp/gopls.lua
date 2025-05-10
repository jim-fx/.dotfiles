return {
  cmd = { "gopls" },
  filetypes = { "go" },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        S1025 = true,  -- Don't use fmt.Sprintf("%s", x) unnecessarily
        SA1000 = true, -- Invalid regular expression
        SA1002 = true, -- Invalid format in time.Parse
        ST1012 = true, -- Error variables that are part of an API should be called errFoo or ErrFoo.
      },
      semanticTokens = true,
      staticcheck = true,
      gofumpt = true,
      vulncheck = "Imports",
    },
  },
}
