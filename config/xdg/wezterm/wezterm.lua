local wezterm = require('wezterm')
local config = wezterm.config_builder()
local font_config = {
  main = wezterm.font_with_fallback({
    {
      family = '0xProto Nerd Font Mono',
      harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
      stretch = 'Expanded',
    },
    {
      family = 'Apple Color Emoji',
      assume_emoji_presentation = true,
    },
  }),
  frame = wezterm.font({
    family = '0xProto Nerd Font Mono',
    harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
    weight = 'Bold',
  }),
}

require('tab_format').setup(wezterm)
require('palette').setup(wezterm)

config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true
config.keys = require('keys').setup(wezterm)
config.key_tables = require('key_tables').setup(wezterm)
config.mouse_bindings = require('mouse').setup(wezterm)

if wezterm.gui.get_appearance():find('Dark') then
  config.color_scheme = 'tokyonight_storm'
else
  config.color_scheme = 'tokyonight_day'
end

local colorscheme = wezterm.color.get_builtin_schemes()[config.color_scheme]

config.colors = {
  tab_bar = {
    background = colorscheme.background,
    active_tab = {
      bg_color = colorscheme.background,
      fg_color = colorscheme.brights[5], -- blue
    },
    inactive_tab = {
      bg_color = colorscheme.background,
      fg_color = colorscheme.brights[1], -- gray
    },
    inactive_tab_hover = {
      bg_color = colorscheme.background,
      fg_color = colorscheme.brights[7], -- aqua
    },
    inactive_tab_edge = colorscheme.background,
  },
}

config.front_end = 'WebGpu'
config.webgpu_power_preference = 'HighPerformance'

config.font = font_config.main
config.font_size = 14
config.line_height = 1.2
config.allow_square_glyphs_to_overflow_width = 'Always'
config.audible_bell = 'Disabled'

config.native_macos_fullscreen_mode = false
config.adjust_window_size_when_changing_font_size = false

config.window_close_confirmation = 'NeverPrompt'
config.window_decorations = 'RESIZE'
config.window_padding = { left = 5, right = 5, top = 0, bottom = 0 }
config.window_frame = {
  font = font_config.window_frame,
  font_size = config.font_size * 0.7,
  active_titlebar_bg = colorscheme.background,
  inactive_titlebar_bg = colorscheme.background,
}

config.inactive_pane_hsb = { saturation = 0.8, brightness = 0.7 }

config.use_fancy_tab_bar = true
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 80

config.scrollback_lines = 10000

config.term = 'wezterm'

return config
