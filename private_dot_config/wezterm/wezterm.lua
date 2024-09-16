local wezterm = require("wezterm")
local keymap = require("keymap")
local theme = require("theme")

local config = wezterm.config_builder()
config.tab_and_split_indices_are_zero_based = true
config.enable_wayland = false

config.color_scheme = theme.color_scheme
config.use_fancy_tab_bar = theme.use_fancy_tab_bar
config.window_decorations = theme.window_decorations
config.hide_tab_bar_if_only_one_tab = theme.hide_tab_bar_if_only_one_tab
config.colors = theme.colors

config.disable_default_key_bindings = true
config.leader = keymap.leader
config.keys = keymap.keys
config.key_tables = keymap.key_tables

return config
