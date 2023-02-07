-----------------------------------
-- Welcome Screen Configuration --
-----------------------------------

-- Call Alpha With A pcall
local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

-- Enable Alpha Dashboard
local dashboard = require("alpha.themes.dashboard")

-- Remove These ~ ~ ~
vim.opt.fillchars:append({ eob = " " })

-- Disable Status Line so that alpha dashboard look nice
-- vim.cmd [[ au User AlphaReady if winnr('$') == 1 | set laststatus=1 ]]

-- Custom Footer
dashboard.section.footer.val = {
  "Write Programs That Do One Thing And Do It Well.",
}

-- Custom Section
dashboard.section.buttons.val = {
  dashboard.button("n", "  Create New file", ":set laststatus=3 | :ene <BAR> startinsert <CR>"),
  dashboard.button("e", "  Open File Manager", ":set laststatus=3 | :Neotree toggle <CR>"),
  dashboard.button("s", "Δ  Search Sessions", ":Telescope persisted<CR>"),
  dashboard.button("v", "  Neovim Settings ", ":set laststatus=3 | e ~/.config/nvim/init.lua <CR>"),
  dashboard.button("b", "⟳  Recent Files", ":Telescope oldfiles<CR>"),
  -- dashboard.button("s", "  Shell Configuration", ":set laststatus=3 | e ~/.config/zsh/.zshrc <CR>"),
  dashboard.button("u", "  Update Nvim Plugins", ":Lazy update <CR>"),
  dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
}

-- LuaVim Ascii Art
dashboard.section.header.val = {
  [[███╗   ███╗ █████╗ ██╗  ██╗    ███╗   ██╗    ██╗   ██╗██╗███╗   ███╗]],
  [[████╗ ████║██╔══██╗╚██╗██╔╝    ████╗  ██║    ██║   ██║██║████╗ ████║]],
  [[██╔████╔██║███████║ ╚███╔╝     ██╔██╗ ██║    ██║   ██║██║██╔████╔██║]],
  [[██║╚██╔╝██║██╔══██║ ██╔██╗     ██║╚██╗██║    ╚██╗ ██╔╝██║██║╚██╔╝██║]],
  [[██║ ╚═╝ ██║██║  ██║██╔╝ ██╗    ██║ ╚████║     ╚████╔╝ ██║██║ ╚═╝ ██║]],
  [[╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝    ╚═╝  ╚═══╝      ╚═══╝  ╚═╝╚═╝     ╚═╝]],
}

dashboard.section.header.val = {
  [[   __    ]],
  [[  /\ \   ]],
  [[ / /\ \  ]],
  [[/ /__\ \ ]],
  [[\/____\/ ]],
}

-- dashboard.section.header.val = {
--   [[           ____]],
--   [[          /\   \]],
--   [[         /  \   \]],
--   [[        /    \   \]],
--   [[       /      \   \]],
--   [[      /   /\   \   \]],
--   [[     /   /  \   \   \]],
--   [[    /   /    \   \   \]],
--   [[   /   /    / \   \   \]],
--   [[  /   /    /   \   \   \]],
--   [[ /   /    /---------'   \]],
--   [[/   /    /_______________\]],
--   [[\  /                     /]],
--   [[ \/_____________________/   ]],
-- }

-- Layout For Luavim ascii art
dashboard.config.layout = {
  { type = "padding", val = 5 },
  dashboard.section.header,
  { type = "padding", val = 2 },
  dashboard.section.buttons,
  { type = "padding", val = 1 },
  dashboard.section.footer,
}

alpha.setup(dashboard.opts)
