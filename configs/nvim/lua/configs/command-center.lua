local command_center = require("command_center")
local noremap = { noremap = true }

command_center.add({
  {
    description = "Search inside current buffer",
    cmd = "<CMD>Telescope current_buffer_fuzzy_find<CR>",
    keybindings = { "n", "<leader>fl", noremap },
  }, {
    -- If no descirption is specified, command is used to replace descirption by default
    -- You can change this behavior in settigns
    cmd = "<CMD>Telescope find_files<CR>",
  },
  {
    -- If no keybindings specified, no keybindings will be displayed or registered
    description = "Find hidden files",
    cmd = "<CMD>Telescope find_files hidden=true<CR>",
  },
  {
    -- You can specify multiple keybindings for the same command ...
    description = "Show document symbols",
    cmd = "<CMD>Telescope lsp_document_symbols<CR>",
  },
  {
    description = "Show function signaure (hover)",
    cmd = "<CMD>lua vim.lsp.buf.hover()<CR>",
  }, {
    description = "(TS) Organize Imports",
    cmd = "<CMD>OrganizeImports<CR>"
  }, {
    description = "ZenMode",
    cmd = "<CMD>ZenMode<CR>",
    keybindings = { "n", "z", noremap }
  }
})
