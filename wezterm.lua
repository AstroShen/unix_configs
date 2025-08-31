-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = "Obsidian"

config.font = wezterm.font("JetBrains Mono")

-- keybinding
config.leader = { key = "/", mods = "CTRL", timeout_milliseconds = 1000 }
local act = wezterm.action
config.keys = {
  -- panes
  { key = "s", mods = "LEADER",     action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "v", mods = "LEADER",     action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "w", mods = "SUPER|CTRL", action = act.CloseCurrentPane({ confirm = true }) },
  { key = "k", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Up") },
  { key = "j", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Down") },
  { key = "h", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Left") },
  { key = "l", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Right") },
  { key = "k", mods = "SUPER",      action = act.ActivatePaneDirection("Up") },
  { key = "j", mods = "SUPER",      action = act.ActivatePaneDirection("Down") },
  { key = "h", mods = "SUPER",      action = act.ActivatePaneDirection("Left") },
  { key = "l", mods = "SUPER",      action = act.ActivatePaneDirection("Right") },
  -- tabs
  { key = "t", mods = "SUPER|CTRL", action = act.CloseCurrentTab({ confirm = false }) },
  -- pane select
  { key = "p", mods = "LEADER",     action = act.PaneSelect },
}

return config
