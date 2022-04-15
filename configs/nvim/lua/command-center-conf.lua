local command_center = require("command_center")
local noremap = {noremap = true}

command_center.add({
  {
    description = "Search inside current buffer",
    command = "Telescope current_buffer_fuzzy_find",
    keybindings = { "n", "<leader>fl", noremap },
  },  {
    -- If no descirption is specified, command is used to replace descirption by default
    -- You can change this behavior in settigns
    command = "Telescope find_files",
    },
    {
      -- If no keybindings specified, no keybindings will be displayed or registered
      description = "Find hidden files",
      command = "Telescope find_files hidden=true",
    },
    {
    -- You can specify multiple keybindings for the same command ...
    description = "Show document symbols",
    command = "Telescope lsp_document_symbols",
     },
      {
    description = "Show function signaure (hover)",
    command = "lua vim.lsp.buf.hover()",
     },{
    description="(TS) Organize Imports",
    command = "OrganizeImports"
  }
})
