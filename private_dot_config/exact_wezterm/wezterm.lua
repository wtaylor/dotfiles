local wezterm = require("wezterm")
local keymap = require("keymap")
local theme = require("theme")

local config = wezterm.config_builder()

function detect_host_os()
	-- package.config:sub(1,1) returns '\' for windows and '/' for *nix.
	if package.config:sub(1, 1) == "\\" then
		return "windows"
	else
		-- uname should be available on *nix systems.
		local check = io.popen("uname -s")
		local result = check:read("*l")
		check:close()

		if result == "Darwin" then
			return "macos"
		else
			return "linux"
		end
	end
end

local host_os = detect_host_os()

if host_os == "macos" then
	-- check homebrew binary symlinks on startup.
	config.set_environment_variables = {
		PATH = wezterm.home_dir .. ":/opt/homebrew/bin:/opt/podman/bin:/usr/local/bin/:" .. os.getenv("PATH"),
	}

	config.unix_domains = {
		{
			name = "devbox",
			proxy_command = { "/opt/homebrew/bin/podman", "exec", "-i", "devbox", "wezterm", "cli", "proxy" },
		},
	}

	config.font_size = 15.0
end

-- Show which key table is active in the status area
wezterm.on("update-right-status", function(window, pane)
	local name = window:active_key_table()
	if name then
		name = "TABLE: " .. name
	end
	window:set_right_status(name or "")
end)

config.tab_and_split_indices_are_zero_based = true
config.enable_wayland = true

config.color_scheme = theme.color_scheme
config.use_fancy_tab_bar = false
config.window_decorations = "TITLE | RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.colors = theme.colors
config.window_background_opacity = 0.95
config.window_padding = { left = 16, right = 16, top = 16, bottom = 8 }

config.disable_default_key_bindings = true
config.enable_kitty_keyboard = false
config.leader = keymap.leader
config.keys = keymap.keys
config.key_tables = keymap.key_tables

config.audible_bell = "Disabled"
config.adjust_window_size_when_changing_font_size = false

config.default_prog = { "fish", "-l" }

return config
