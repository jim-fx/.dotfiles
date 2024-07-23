local colors = require("colors")
local wezterm = require("wezterm")

local dark_theme = {
  split = colors.surface0,
  foreground = colors.text,
  background = colors.crust,
  cursor_bg = colors.rosewater,
  cursor_border = colors.rosewater,
  cursor_fg = colors.base,
  selection_bg = colors.surface2,
  selection_fg = colors.text,
  visual_bell = colors.surface0,
  indexed = {
    [16] = colors.peach,
    [17] = colors.rosewater,
  },
  scrollbar_thumb = colors.surface2,
  compose_cursor = colors.flamingo,
  ansi = {
    colors.surface1,
    colors.red,
    colors.green,
    colors.yellow,
    colors.blue,
    colors.pink,
    colors.teal,
    colors.subtext0,
  },
  brights = {
    colors.subtext0,
    colors.red,
    colors.green,
    colors.yellow,
    colors.blue,
    colors.pink,
    colors.teal,
    colors.surface1,
  },
  tab_bar = {
    background = colors.crust,
    active_tab = {
      bg_color = "none",
      fg_color = colors.subtext1,
      intensity = "Bold",
      underline = "None",
      italic = false,
      strikethrough = false,
    },
    inactive_tab = {
      bg_color = colors.crust,
      fg_color = colors.surface2,
    },
    inactive_tab_hover = {
      bg_color = colors.mantle,
      fg_color = colors.subtext0,
    },
    new_tab = {
      bg_color = colors.crust,
      fg_color = colors.subtext0,
    },
    new_tab_hover = {
      bg_color = colors.crust,
      fg_color = colors.subtext0,
    },
  },
}

local light_theme = {
  split = colors.surface0,
  foreground = colors.crust,
  background = "#fff",
  cursor_bg = colors.rosewater,
  cursor_border = colors.rosewater,
  cursor_fg = colors.base,
  selection_bg = colors.surface2,
  selection_fg = colors.text,
  visual_bell = colors.surface0,
  indexed = {
    [16] = colors.peach,
    [17] = colors.rosewater,
  },
  scrollbar_thumb = colors.surface2,
  compose_cursor = colors.flamingo,
  ansi = {
    colors.surface1,
    colors.red,
    colors.green,
    colors.yellow,
    colors.blue,
    colors.pink,
    colors.teal,
    colors.subtext0,
  },
  brights = {
    colors.subtext0,
    colors.red,
    colors.green,
    colors.yellow,
    colors.blue,
    colors.pink,
    colors.teal,
    colors.surface1,
  },
  tab_bar = {
    background = colors.text,
    active_tab = {
      bg_color = "none",
      fg_color = colors.surface1,
      intensity = "Bold",
      underline = "None",
      italic = false,
      strikethrough = false,
    },
    inactive_tab = {
      bg_color = colors.text,
      fg_color = colors.surface2,
    },
    inactive_tab_hover = {
      bg_color = colors.mantle,
      fg_color = colors.subtext0,
    },
    new_tab = {
      bg_color = colors.crust,
      fg_color = colors.subtext0,
    },
    new_tab_hover = {
      bg_color = colors.crust,
      fg_color = colors.subtext0,
    },
  },
}


local function is_dark_mode()
  local appearance = wezterm.gui and wezterm.gui.get_appearance() or "Dark"
  return appearance:find 'Dark'
end


return {
  get_theme_name = function()
    return is_dark_mode()
        and '3024 Night'
        or '3024 Day'
  end,
  get_colors = function()
    return is_dark_mode()
        and dark_theme
        or light_theme
  end
}
