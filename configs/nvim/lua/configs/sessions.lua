require("persistence").setup({
  autoload = true,
  use_git_branch = false,
  before_save = function()
    pcall(vim.cmd, ":NvimTreeClose")
  end,
  after_source = function()
    -- Reload the LSP servers
    vim.lsp.stop_client(vim.lsp.get_active_clients())
    pcall(vim.cmd, ":NvimTreeOpen");
  end,
  dir = vim.fn.stdpath('data') .. '/sessions/'
})
