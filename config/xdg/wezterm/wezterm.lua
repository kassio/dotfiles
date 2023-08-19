local wezterm = require('wezterm')
local config = wezterm.config_builder()

require('tab_format').setup(wezterm)

wezterm.on('window-config-reloaded', function()
  local os = require('os')

  local cmd = table.concat({
    os.getenv('HOME'),
    '.dotfiles',
    'bin',
    'update-nvim-appearance',
  }, '/')
  local r, s = os.execute(cmd)

  wezterm.log_info(cmd, r, s)
end)

config.keys = require('keys').setup(wezterm)

local colorscheme_name = 'Catppuccin Latte'
if wezterm.gui.get_appearance():find('Dark') then
  colorscheme_name = 'Catppuccin Mocha'
end

local colorscheme = wezterm.color.get_builtin_schemes()[colorscheme_name]

config.color_scheme = colorscheme_name
config.colors = colorscheme

config.font_size = 16
config.line_height = 1.2
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
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

config.window_frame = {
  font = wezterm.font({
    family = 'JetBrains Mono',
    harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
    stretch = 'Expanded',
    weight = 'ExtraBlack', -- really heavy
  }),

  font_size = config.font_size * 0.6,
  active_titlebar_bg = colorscheme.background,
  inactive_titlebar_bg = colorscheme.background,
}

config.inactive_pane_hsb = { saturation = 0.8, brightness = 0.7 }

config.use_fancy_tab_bar = true
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 80

config.term = 'wezterm'

return config
