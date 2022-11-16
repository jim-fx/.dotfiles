local Workspace = require("projections.workspace")
local Session = require("projections.session")

require("projections").setup({
  workspaces = { "~/Projects" }, -- Default workspaces to search for
  patterns = { ".git", ".svn", ".hg" }, -- Patterns to search for, these are NOT regexp
  store_hooks = {
    pre = function()
      require("nvim-tree").close()
    end,
  },
  restore_hooks = {
    post = function()
      require("nvim-tree").open()
    end,
  },
})

vim.keymap.set("n", "<leader>o", function()
  local find_projects = require("telescope").extensions.projections.projections
  find_projects({
    action = function(selection)
      -- chdir is required since there might not be a session file
      vim.fn.chdir(selection.value)
      Session.restore(selection.value)
    end,
  })
end, { desc = "Find projects" })

vim.api.nvim_create_autocmd({ "DirChangedPre", "VimLeavePre" }, {
  callback = function()
    Session.store(vim.loop.cwd())
  end,
  desc = "Store project session",
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    if 0 then
      return
    end
    local session_info = Session.info(vim.loop.cwd())
    if session_info == nil then
      Session.restore_latest()
    else
      Session.restore(vim.loop.cwd())
    end
  end,
  desc = "Restore last session automatically",
})

vim.api.nvim_create_user_command("RestoreSession", function()
  local session_info = Session.info(vim.loop.cwd())
  if session_info == nil then
    Session.restore_latest()
  else
    Session.restore(vim.loop.cwd())
  end
end, {})

vim.api.nvim_create_user_command("SaveSession", function()
  Session.store(vim.loop.cwd())
end, {})

-- Add workspace command
vim.api.nvim_create_user_command("AddWorkspace", function()
  Workspace.add(vim.loop.cwd())
end, {})
