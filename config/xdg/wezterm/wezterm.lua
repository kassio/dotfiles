local wezterm = require('wezterm')
local config = wezterm.config_builder()

local colorscheme_name = 'Catppuccin Latte'
if wezterm.gui.get_appearance():find('Dark') then
  return 'Catppuccin Mocha'
end

-- local colorscheme = wezterm.color.get_builtin_schemes(colorscheme_name)

config.color_scheme = colorscheme_name

config.font = wezterm.font({
  family = 'JetBrains Mono',
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
  stretch = 'Expanded',
  weight = 'Medium',
})
config.font_size = 16

config.adjust_window_size_when_changing_font_size = false

config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.audible_bell = 'Disabled'

config.native_macos_fullscreen_mode = false
config.window_close_confirmation = 'NeverPrompt'
config.window_decorations = 'RESIZE'
config.window_padding = {
  left = 1,
  right = 1,
  top = 0,
  bottom = 0,
}

config.keys = require('keys').setup(wezterm)

return config
