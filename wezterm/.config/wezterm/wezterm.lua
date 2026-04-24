local wezterm = require "wezterm"
local config = wezterm.config_builder()

-- Appearance
config.color_scheme = "Dracula (Official)"
config.font = wezterm.font("JetBrains Mono", { weight = "Regular" })
config.font_size = 13.0
config.window_background_opacity = 0.95
config.hide_tab_bar_if_only_one_tab = true

-- Performance
config.front_end = "WebGpu"
config.max_fps = 120

-- Pass modifier keys through to nvim (needed for Alt+Enter, Ctrl+b etc.)
config.enable_kitty_keyboard = true
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

-- Window
config.window_padding = { left = 4, right = 4, top = 4, bottom = 4 }

-- Keys: pane splitting and navigation (mirrors vim-tmux-navigator)
local act = wezterm.action

config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
  -- Send Ctrl+b through to apps (press twice)
  { key = "b", mods = "LEADER", action = act.SendKey { key = "b", mods = "CTRL" } },

  -- Pass F-keys through explicitly
  { key = "F4",  mods = "",           action = act.SendKey { key = "F4" } },
  { key = "F10", mods = "",           action = act.SendKey { key = "F10" } },
  { key = "F10", mods = "SHIFT",      action = act.SendKey { key = "F10", mods = "SHIFT" } },
  { key = "F10", mods = "CTRL|SHIFT", action = act.SendKey { key = "F10", mods = "CTRL|SHIFT" } },

  -- Pane splitting (tmux: % and ")
  { key = "%", mods = "LEADER|SHIFT", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
  { key = '"', mods = "LEADER|SHIFT", action = act.SplitVertical { domain = "CurrentPaneDomain" } },

  -- Navigate panes (tmux: arrow keys)
  { key = "LeftArrow",  mods = "LEADER", action = act.ActivatePaneDirection "Left" },
  { key = "DownArrow",  mods = "LEADER", action = act.ActivatePaneDirection "Down" },
  { key = "UpArrow",    mods = "LEADER", action = act.ActivatePaneDirection "Up" },
  { key = "RightArrow", mods = "LEADER", action = act.ActivatePaneDirection "Right" },

  -- Navigate panes vim-style (tmux: hjkl)
  { key = "h", mods = "LEADER", action = act.ActivatePaneDirection "Left" },
  { key = "j", mods = "LEADER", action = act.ActivatePaneDirection "Down" },
  { key = "k", mods = "LEADER", action = act.ActivatePaneDirection "Up" },
  { key = "l", mods = "LEADER", action = act.ActivatePaneDirection "Right" },

  -- Resize panes (tmux: Ctrl+arrow)
  { key = "LeftArrow",  mods = "LEADER|CTRL", action = act.AdjustPaneSize { "Left",  5 } },
  { key = "DownArrow",  mods = "LEADER|CTRL", action = act.AdjustPaneSize { "Down",  5 } },
  { key = "UpArrow",    mods = "LEADER|CTRL", action = act.AdjustPaneSize { "Up",    5 } },
  { key = "RightArrow", mods = "LEADER|CTRL", action = act.AdjustPaneSize { "Right", 5 } },

  -- Tabs (tmux: c, n, p, &, 1-9)
  { key = "c", mods = "LEADER", action = act.SpawnTab "CurrentPaneDomain" },
  { key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
  { key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
  { key = "&", mods = "LEADER|SHIFT", action = act.CloseCurrentTab { confirm = true } },
  { key = "x", mods = "LEADER", action = act.CloseCurrentPane { confirm = true } },
  { key = "1", mods = "LEADER", action = act.ActivateTab(0) },
  { key = "2", mods = "LEADER", action = act.ActivateTab(1) },
  { key = "3", mods = "LEADER", action = act.ActivateTab(2) },
  { key = "4", mods = "LEADER", action = act.ActivateTab(3) },
  { key = "5", mods = "LEADER", action = act.ActivateTab(4) },
  { key = "6", mods = "LEADER", action = act.ActivateTab(5) },
  { key = "7", mods = "LEADER", action = act.ActivateTab(6) },
  { key = "8", mods = "LEADER", action = act.ActivateTab(7) },
  { key = "9", mods = "LEADER", action = act.ActivateTab(8) },

  -- Misc (tmux: z zoom, [ copy mode, d detach)
  { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
  { key = " ", mods = "LEADER", action = act.RotatePanes "Clockwise" },
  { key = "[", mods = "LEADER", action = act.ActivateCopyMode },
  { key = "w", mods = "LEADER", action = act.ShowTabNavigator },
  { key = ",", mods = "LEADER", action = act.PromptInputLine {
    description = "Rename tab",
    action = wezterm.action_callback(function(window, _, line)
      if line then window:active_tab():set_title(line) end
    end),
  }},
}

return config
