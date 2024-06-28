-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.color_scheme = 'Nord (base16)'
config.font = wezterm.font 'FiraCode Nerd Font Mono'

-- and finally, return the configuration to wezterm
return config
