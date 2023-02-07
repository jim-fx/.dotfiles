require("scrollbar").setup({
  handlers = {
    cursor = true,
    diagnostic = true,
    gitsigns = true, -- Requires gitsigns
    handle = true,
    search = false, -- Requires hlslens
  },
  excluded_filetypes = {
    "prompt",
    "TelescopePrompt",
    "noice",
    "NvimTree",
    "neo-tree"
  },
})
