local wezterm = require('wezterm')
local config = wezterm.config_builder()

require('tab_format').setup(wezterm)

config.keys = require('keys').setup(wezterm)

local colorscheme_name = 'Catppuccin Latte'
if wezterm.gui.get_appearance():find('Dark') then
  colorscheme_name = 'Catppuccin Mocha'
end

local colorscheme = wezterm.color.get_builtin_schemes()[colorscheme_name]

colorscheme.tab_bar.background = colorscheme.background
colorscheme.tab_bar.active_tab.fg_color = colorscheme.tab_bar.active_tab.bg_color
colorscheme.tab_bar.active_tab.bg_color = colorscheme.background
colorscheme.tab_bar.inactive_tab.bg_color = colorscheme.background
colorscheme.tab_bar.inactive_tab.fg_color = colorscheme.brights[1] -- gray
colorscheme.tab_bar.inactive_tab_hover.fg_color = colorscheme.brights[5] -- blue
colorscheme.tab_bar.inactive_tab_edge = colorscheme.background

config.color_scheme = colorscheme_name
config.colors = colorscheme

config.font_size = 16
config.line_height = 1.2
config.allow_square_glyphs_to_overflow_width = 'Never'
config.font = wezterm.font({
  family = 'JetBrains Mono',
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
  stretch = 'Expanded',
  weight = 'Regular',
})

config.audible_bell = 'Disabled'

config.native_macos_fullscreen_mode = false
config.adjust_window_size_when_changing_font_size = false

config.window_close_confirmation = 'NeverPrompt'
config.window_decorations = 'RESIZE'
config.window_padding = { left = 5, right = 5, top = 0, bottom = 0 }
config.window_frame = {
  font = wezterm.font({
    family = 'JetBrains Mono',
    harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
    weight = 'Bold',
  }),

  font_size = config.font_size * 0.7,
  active_titlebar_bg = colorscheme.background,
  inactive_titlebar_bg = colorscheme.background,
}

config.inactive_pane_hsb = { saturation = 0.8, brightness = 0.7 }

config.use_fancy_tab_bar = true
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 80

config.term = 'wezterm'

return config
