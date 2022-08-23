local wezterm = require("wezterm")

return {
  font = wezterm.font("FiraCodeNerdFont"),
  font_size = 13,
  -- You can specify some parameters to influence the font selection;
  -- for example, this selects a Bold, Italic font variant.
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
}
