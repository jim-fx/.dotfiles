local gesture = require("gesture")

vim.keymap.set("n", "<RightMouse>", [[<Nop>]])
vim.keymap.set("n", "<RightDrag>", [[<Cmd>lua require("gesture").draw()<CR>]], { silent = true })
vim.keymap.set("n", "<RightRelease>", [[<Cmd>lua require("gesture").finish()<CR>]], { silent = true })

gesture.register({
  name = "go back",
  inputs = { gesture.right() },
  -- map to `<C-o>` keycode
  action = [[lua vim.cmd('sp')]],
})


gesture.register({
  name = "go back",
  inputs = { gesture.down() },
  -- map to `<C-o>` keycode
  action = [[lua vim.cmd('vsp')]],
})

-- gesture.register({
--   name = "scroll to bottom",
--   inputs = { gesture.right() },
--   action = "normal! G",
-- })

