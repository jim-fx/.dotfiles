local map = vim.api.nvim_set_keymap;
local function run(verbose)
  return require("rest-nvim").run(verbose);
end

local preview = function()
  return run(true)
end

map("n", "<leader>r", run, { noremap = true });
map("n", "<leader>p", preview, { noremap = true });
