local wezterm = require("wezterm")
local utils = require("utils")
local colors = require("colors")

local function get_current_working_dir(tab)
  local current_dir = tab.active_pane.current_working_dir
  local HOME_DIR = string.format("file://%s", os.getenv("HOME"))

  return current_dir == HOME_DIR and "  ~"
      or string.format(" %s", string.gsub(current_dir, "(.*[/\\])(.*)", "%2"))
end

wezterm.on("format-tab-title", function(tab)
  return wezterm.format({
    { Attribute = { Intensity = "Half" } },
    { Text = tab.is_active and " [" or "  " },
    { Text = utils.get_process(tab) },
    { Text = "  " },
    { Text = get_current_working_dir(tab) },
    { Text = tab.is_active and "] " or "  " },
    { Foreground = { Color = colors.base } },
  })
end)

wezterm.on("update-status", function(window)
  window:set_right_status(wezterm.format({
    { Attribute = { Intensity = "Bold" } },
    { Text = wezterm.strftime("%H:%M ") },
  }))
end)

local os_config = {}

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then

  local wsl_domains = wezterm.default_wsl_domains()
  for _, dom in ipairs(wsl_domains) do
    dom.default_cwd = "/home/max"
  end
  os_config = {
    wsl_domains = wsl_domains,
    default_domain = "WSL:Debian",
  }
else
  os_config = {
    window_padding = {
      left = 20,
      right = 20,
      top = 20,
      bottom = 20,
    },
  }
end

return utils.merge({
  font = wezterm.font_with_fallback({
    "Liga SFMono Nerd Font",
    "Apple Color Emoji",
  }),
  font_size = 12.1,
  max_fps = 120,
  pane_focus_follows_mouse = false,
  warn_about_missing_glyphs = false,
  show_update_window = true,
  check_for_updates = true,
  line_height = 1.30,
  window_decorations = "RESIZE",
  window_close_confirmation = "AlwaysPrompt",
  audible_bell = "Disabled",
  window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 10,
  },
  inactive_pane_hsb = {
    saturation = 0.5,
    brightness = 0.5,
  },
  enable_scroll_bar = false,
  use_fancy_tab_bar = false,
  show_new_tab_button_in_tab_bar = false,
  window_background_opacity = 1.0,
  tab_max_width = 50,
  hide_tab_bar_if_only_one_tab = true,
  disable_default_key_bindings = false,
  colors = {
    split = colors.surface0,
    foreground = colors.text,
    background = colors.base,
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
  },
  color_scheme = "3024 Night",
  leader = { key = "a", mods = "CTRL" },
  keys = {
    -- Keybindings similar to tmux
    { key = "-", mods = "LEADER", action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
    { key = "\\", mods = "LEADER", action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },

    --
    { key = "z", mods = "LEADER", action = "TogglePaneZoomState" },
    { key = "c", mods = "LEADER", action = wezterm.action { SpawnTab = "CurrentPaneDomain" } },
    --
    { key = "n", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) },
    { key = "p", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) },
    --
    { key = "h", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
    { key = "l", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
    { key = "k", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
    { key = "j", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
    --
    { key = "H", mods = "SHIFT|ALT", action = wezterm.action({ AdjustPaneSize = { "Left", 2 } }) },
    { key = "L", mods = "SHIFT|ALT", action = wezterm.action({ AdjustPaneSize = { "Right", 2 } }) },
    { key = "J", mods = "SHIFT|ALT", action = wezterm.action({ AdjustPaneSize = { "Down", 2 } }) },
    { key = "K", mods = "SHIFT|ALT", action = wezterm.action({ AdjustPaneSize = { "Up", 2 } }) },
    ---
    { key = 'P', mods = 'CMD|SHIFT', action = wezterm.action.ActivateCommandPalette, },
    { key = 'U', mods = 'CMD|SHIFT', action = wezterm.action.Nop, },
    { key = 'F11', mods = '', action = wezterm.action.ToggleFullScreen, },
  },
  hyperlink_rules = {
    {
      regex = "\\b\\w+://[\\w.-]+:[0-9]{2,15}\\S*\\b",
      format = "$0",
    },
    {
      regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b",
      format = "$0",
    },
    {
      regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]],
      format = "mailto:$0",
    },
    {
      regex = [[\bfile://\S*\b]],
      format = "$0",
    },
    {
      regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]],
      format = "$0",
    },
    {
      regex = [[\b[tT](\d+)\b]],
      format = "https://example.com/tasks/?t=$1",
    },
  },
}, os_config)
