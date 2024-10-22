local wezterm = require("wezterm")
local config = wezterm.config_builder()
config.enable_wayland = true
config.enable_tab_bar = false
config.window_background_opacity = 0.9
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.window_close_confirmation = "NeverPrompt"
config.default_cursor_style = "BlinkingUnderline"
config.cursor_blink_rate = 700
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("CaskaydiaCove NFM")
config.font_size = 12.0
return config
