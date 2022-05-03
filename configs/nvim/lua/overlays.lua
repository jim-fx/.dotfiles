local Terminal = require("toggleterm.terminal").Terminal
local lazygit =
Terminal:new(
  {
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    winblend = 0,
    border = "shadow"
  },
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  end,
  on_close = function()
    Terminal:close()
  end
}
)

function _Lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<C-g>", "<cmd>lua _Lazygit_toggle()<CR>", { noremap = true, silent = true })

local pnpm =
Terminal:new(
  {
  cmd = "pnpm dev",
  dir = "git_dir",
  size = 5,
  direction = "vertical",
  on_close = function(term)
    Terminal:close()
  end
}
)

function _Pnpm_toggle()
  pnpm:toggle()
end

vim.api.nvim_set_keymap("n", "<Leader>d", "<cmd>lua _Pnpm_toggle()<CR>", { noremap = true, silent = true })

local chtConfig =
Terminal:new(
  {
  cmd = "cht",
  direction = "float"
}
)

function _chtConfig_toggle()
  chtConfig:toggle()
end

vim.api.nvim_set_keymap("n", "<Leader><C-l>", "<cmd>lua _chtConfig_toggle()<CR>", { noremap = true, silent = true })

require("toggleterm").setup {
  shade_terminals = true
}
