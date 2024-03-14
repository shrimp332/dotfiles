local wezterm = require("wezterm")
local config = wezterm.config_builder()
config.enable_wayland = true
config.enable_tab_bar = false
config.window_background_opacity = 0.6
config.default_cursor_style = 'SteadyUnderline'
config.color_scheme = 'tokyonight'
config.font = wezterm.font 'CaskaydiaCove NFM'
config.font_size = 12.0
return config
