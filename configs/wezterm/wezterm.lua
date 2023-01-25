local wezterm = require("wezterm")

local padding = 30

local function scheme_for_appearance(appearance)
  if appearance:find("Dark") then
    return "3024 Night"
  else
    return "Catppuccin Latte"
  end
end

local wsl_domains = wezterm.default_wsl_domains()

-- Always use zsh in my WSL.  but really: I recommend running `chsh` inside WSL to make it the default!
for _, dom in ipairs(wsl_domains) do
  dom.default_cwd = "/home/max"
  print(dom.name)
end

return {
  font = wezterm.font_with_fallback {
    "FiraCodeNerdFont",
    "Noto Color Emoji"
  },
  wsl_domains = wsl_domains,
  font_size = 13,
  -- You can specify some parameters to influence the font selection;
  -- for example, this selects a Bold, Italic font variant.
  -- color_scheme = "Batman",
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  alternate_buffer_wheel_scroll_speed = 1,
  color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
  window_close_confirmation = "AlwaysPrompt",
  keys = {
    {
      key = 'U',
      mods = 'CMD|SHIFT',
      action = wezterm.action.Nop,
    },
  },
  window_padding = {
    left = padding,
    right = padding,
    top = padding,
    bottom = padding,
  },
}
