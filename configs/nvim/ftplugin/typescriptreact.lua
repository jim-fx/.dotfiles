-- ftplugin/vue.lua
vim.keymap.set('i', '/', function()
  local node = vim.treesitter.get_node()
  if not node then
    return '/'
  end

  local first_sibling_node = node:prev_named_sibling()
  if not first_sibling_node then
    return '/'
  end

  local parent_node = node:parent()
  local is_tag_writing_in_progress = node:type() == 'text' and parent_node:type() == 'element'

  local is_start_tag = first_sibling_node:type() == 'start_tag'

  local start_tag_text = vim.treesitter.get_node_text(first_sibling_node, 0)
  local tag_is_already_terminated = string.match(start_tag_text, '>$')

  if
      is_tag_writing_in_progress
      and is_start_tag
      and not tag_is_already_terminated
  then
    local char_at_cursor = vim.fn.strcharpart(
      vim.fn.strpart(vim.fn.getline '.', vim.fn.col '.' - 2),
      0,
      1
    )
    local already_have_space = char_at_cursor == ' '

    -- We can also automatically add a space if there isn't one already
    return already_have_space and '/>' or ' />'
  end

  return '/'
end, { expr = true, buffer = true })
