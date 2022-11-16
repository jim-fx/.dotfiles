local wezterm = require 'wezterm'
local act = wezterm.action

local default_prog
local default_cwd
local font_size
local tab_font_size
local initial_rows
local inital_cols

if string.find(wezterm.target_triple, "windows") then
  default_prog = { "wsl.exe" };
  default_cwd = os.getenv("HOME");
  tab_font_size = 9.0;
  font_size = 10.7;
  initial_rows = 43;
  initial_cols = 180;
end

if string.find(wezterm.target_triple, "darwin") then
  tab_font_size = 15.0;
  font_size = 16;
  initial_rows = 38;
  initial_cols = 120;
end

local keys = {
  -- Keyboard Navigation
  --- delete words backwards
  { key = "Backspace", mods = "CTRL", action = { SendKey = { key = "U", mods = "CTRL" } } },
  { key = "Backspace", mods = "CMD", action = { SendKey = { key = "U", mods = "CTRL" } } },
  { key = "Backspace", mods = "ALT", action = { SendKey = { key = "W", mods = "CTRL" } } },

  --- home and end
  { key = "LeftArrow", mods = "CTRL", action = { SendKey = { key = "Home" } } },
  { key = "LeftArrow", mods = "CMD", action = { SendKey = { key = "Home" } } },
  { key = "RightArrow", mods = "CTRL", action = { SendKey = { key = "End" } } },
  { key = "RightArrow", mods = "CMD", action = { SendKey = { key = "End" } } },

  --- move one word
  { key = "LeftArrow", mods = "ALT", action = { SendKey = { key = "LeftArrow", mods = "CTRL" } } },
  { key = "RightArrow", mods = "ALT", action = { SendKey = { key = "RightArrow", mods = "CTRL" } } },

  --- ctrl + jk keyboard navigation
  { key = "k", mods = "ALT", action = { SendKey = { key = "UpArrow" } } },
  { key = "k", mods = "CMD", action = { SendKey = { key = "UpArrow" } } },
  { key = "j", mods = "ALT", action = { SendKey = { key = "DownArrow" } } },
  { key = "j", mods = "CMD", action = { SendKey = { key = "DownArrow" } } },

  --- accept completion on ctrl|alt|cmd + .
  { key = ".", mods = "CTRL", action = { SendKey = { key = "RightArrow" } } },
  { key = ".", mods = "ALT", action = { SendKey = { key = "RightArrow" } } },
  { key = ".", mods = "CMD", action = { SendKey = { key = "RightArrow" } } },

  -- Fullscreen
  { key = "Enter", mods = "CTRL", action = "ToggleFullScreen" },
  { key = "Enter", mods = "CMD", action = "ToggleFullScreen" },
  { key = "Enter", mods = "ALT", action = "ToggleFullScreen" },

  -- Clear Screen
  { key = "l", mods = "CMD", action = { SendKey = { key = "l", mods = "CTRL" } } },
  { key = "l", mods = "ALT", action = { SendKey = { key = "l", mods = "CTRL" } } },
  { key = "k", mods = "CMD", action = { SendKey = { key = "l", mods = "CTRL" } } },

  -- Copy/Paste
  { key = "c", mods = "ALT", action = "Copy" },
  { key = "c", mods = "CMD", action = "Copy" },
  { key = "v", mods = "ALT", action = "Paste" },
  { key = "v", mods = "CMD", action = "Paste" },

  -- Open New Window
  { key = "t", mods = "CMD", action = { SpawnTab = "CurrentPaneDomain" } },
  { key = "t", mods = "ALT", action = { SpawnTab = "CurrentPaneDomain" } },
  { key = "n", mods = "CMD", action = "SpawnWindow" },
  { key = "n", mods = "ALT", action = "SpawnWindow" },
  { key = "w", mods = "ALT", action = { EmitEvent = "CloseCurrentTab" } },
  { key = "w", mods = "CMD", action = { EmitEvent = "CloseCurrentTab" } },

  -- Open the config
  { key = ",", mods = "ALT", action = { SendString = "vim ~/.config/wezterm/wezterm.lua\r\n" } },
  { key = ",", mods = "CMD", action = { SendString = "vim ~/.config/wezterm/wezterm.lua\r\n" } },
};

-- ALT-Tab
for i = 1, 9 do
  table.insert(keys, { key = tostring(i), mods = "ALT", action = wezterm.action { ActivateTab = i - 1 } })
  table.insert(keys, { key = tostring(i), mods = "CTRL", action = wezterm.action { ActivateTab = i - 1 } });
end

-- Delegate close confirmation to some apps such as VIM, etc.
wezterm.on("CloseCurrentTab", function(window, pane)
  function is_vim()
    local current_process = pane:get_title():upper()
    return current_process:sub(- #"NVIM") == "NVIM" or current_process:sub(1, #"NVIM") == "NVIM" or
        current_process:sub(- #"VIM") == "VIM" or current_process:sub(1, #"VIM") == "VIM" or
        current_process:sub(- #"VI") == "VI" or current_process:sub(1, #"VI") == "VI"
  end

  if is_vim() then
    window:perform_action(wezterm.action {
      SendKey = { key = "Z", mods = "CTRL" }
    }, pane)
  else
    window:perform_action(wezterm.action {
      CloseCurrentTab = { confirm = false }
    }, pane)
  end
end)

-- Colors
local colors = {
  -- Tab Bar Ayu Mirage
}

local color_schemes = {
  ["Ayu"] = {
    background = "#0f1419",
  }
};

return {
  -- General
  default_prog = default_prog,
  default_cwd = default_cwd,
  exit_behavior = "Close",

  -- Key Bindings
  keys = keys,

  -- Window
  initial_rows = initial_rows,
  initial_cols = initial_cols,
  window_padding = { left = 1, right = 1, top = 0, bottom = 0 },

  -- Appearance and Colors
  color_scheme = "Ayu",
  colors = colors,
  color_schemes = color_schemes,
  window_decorations = "RESIZE",
  default_cursor_style = "SteadyBlock",
  audible_bell = "Disabled",
  font_size = font_size,
  harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
  window_frame = { font_size = tab_font_size, }
}

