local function get_highlight_foreground(group)
  local synID = vim.fn.hlID(group)
  return vim.fn.synIDattr(synID, 'fg', 'gui')
end

return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  event = "BufWinEnter",
  config = function()
    local bufferline = require("bufferline");
    bufferline.setup({
      highlights = {
        background = {
          bg = "none",
        },
        separator = {
          bg = "none",
        },
        fill = {
          bg = "none"
        },
        offset_separator = {
          bg = "none",
          fg = "#454545",
          bold = false,
        },
        buffer_selected = {
          bg = "#2a2b3c",
          bold = true,
          italic = false,
        },
        indicator_selected = {
          bg = "none",
        },
      },
      options = {
        close_command = 'Bdelete! %d',
        right_mouse_command = 'Bdelete! %d',
        left_mouse_command = 'buffer %d',
        middle_mouse_command = nil,
        themable = true,
        indicator = {
          style = 'icon',
          icon = ' ', --'▎',
          buffer_close_icon = ' ',
          modified_icon = '●',
          close_icon = ' ',
          left_trunc_marker = '<-',  --'',
          right_trunc_marker = '->', --'',
        },
        offsets = { { filetype = "neo-tree", text = "", text_align = "left", separator = true, highlight = "Directory" } },

        get_element_icon = function(element)
          -- element consists of {filetype: string, path: string, extension: string, directory: string}
          -- This can be used to change how bufferline fetches the icon
          -- for an element e.g. a buffer or a tab.
          -- e.g.
          local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
          if hl then
            local fg = get_highlight_foreground(hl) or "#ffffff"
            -- vim.cmd("hi BufferLine" .. hl .. " guifg=" .. fg .. " guibg=#1c1d23");
            vim.cmd("hi BufferLine" .. hl .. "Selected guifg=" .. fg .. " guibg=#2a2b3c");
          end
          return icon, hl
        end,
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = false,
        persist_buffer_sort = true,
        separator_style = "thin",
        enforce_regular_tabs = true,
        always_show_bufferline = true,
        sort_by = 'id',
      }
    })
  end
}
