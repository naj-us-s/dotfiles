-- WezTerm configuration with Nyoom Engineering theme
local wezterm = require("wezterm")
local constants = require("constants")
local commands = require("commands")
local config = wezterm.config_builder()

config.font_size = 19
config.line_height = 1.2
config.font = wezterm.font("BlexMono Nerd Font")

config.color_scheme_dirs = { os.getenv("HOME") .. "/.config/wezterm/colors" }
config.color_scheme = "oxocarbon"

config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.default_cursor_style = "Block"

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.window_background_opacity = 0.8
config.macos_window_background_blur = 40

-- Toggle transparency: Ctrl+Shift+T (opaque ↔ transparent with blur)
wezterm.on("toggle-transparency", function(window)
	local overrides = window:get_config_overrides() or {}
	local effective = window:effective_config()
	local current_opacity = effective.window_background_opacity or 1
	if current_opacity < 1 then
		overrides.window_background_opacity = 1
		overrides.macos_window_background_blur = 0
	else
		overrides.window_background_opacity = 0.8
		overrides.macos_window_background_blur = 40
	end
	window:set_config_overrides(overrides)
end)

config.keys = {
	{
		key = "t",
		mods = "CTRL|SHIFT",
		action = wezterm.action.EmitEvent("toggle-transparency"),
	},
}

config.max_fps = 120
config.prefer_egl = true

--Gpu rendering
config.front_end = "WebGpu"

wezterm.on("augment-command-palette", function()
	return commands
end)

return config
