local wezterm = require("wezterm")

local padding = 30

return {
  font = wezterm.font("FiraCodeNerdFont"),
  font_size = 13,
  -- You can specify some parameters to influence the font selection;
  -- for example, this selects a Bold, Italic font variant.
  -- color_scheme = "Batman",
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  alternate_buffer_wheel_scroll_speed = 1,
  window_close_confirmation = "AlwaysPrompt",
  window_padding = {
    left = padding,
    right = padding,
    top = padding,
    bottom = padding,
  },
}
