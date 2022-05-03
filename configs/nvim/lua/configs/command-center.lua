local command_center = require("command_center")
local noremap = { noremap = true }

command_center.add({
  {
    description = "Show Sessions",
    cmd = ":lua require('session-lens').search_session()<CR>",
    keybindings = { "n", "<leader><C-o>", noremap }
  },
  {
    description = "ZenMode",
    cmd = "<CMD>ZenMode<CR>",
    keybindings = { "n", "z", noremap }
  },
  {
    description = "Search inside current buffer",
    cmd = "<CMD>Telescope current_buffer_fuzzy_find<CR>",
    keybindings = { "n", "<leader>fl", noremap },
  },
  {
    description = "Show document symbols",
    cmd = "<CMD>Telescope lsp_document_symbols<CR>",
  },
  {
    description = "Show function signaure (hover)",
    cmd = "<CMD>lua vim.lsp.buf.hover()<CR>",
  },
  {
    description = "(TS) Organize Imports",
    cmd = "<CMD>OrganizeImports<CR>"
  },
})
