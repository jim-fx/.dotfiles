require("persisted").setup({
  autoload = true,
  before_save = function()
    local tree = pcall(require, "nvim-tree")
    if tree then
      vim.cmd("NvimTreeClose")
    end
  end,
  after_save = function()
    vim.cmd("NvimTreeOpen")
  end,
  after_source = function()
    vim.lsp.stop_client(vim.lsp.get_active_clients())
    vim.cmd("filetype detect")
  end,
})
require("telescope").load_extension("persisted") -- To load the telescope extension
