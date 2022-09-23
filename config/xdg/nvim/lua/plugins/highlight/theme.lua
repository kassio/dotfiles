local colors = {
  error = '#CA1243',
  warn = '#F7C154',
  info = '#6699CC',
  hint = '#50A14F',
  light_error = '#FD83A1',
  light_warn = '#FFF4A8',
  light_info = '#A5D0FF',
  light_hint = '#B5E6CE',
}

local icons = {
  buffer = '',
  bug = '',
  error = '',
  hint = '',
  info = '',
  nvim_lsp = '',
  nvim_lua = '',
  path = 'פּ',
  separator = ' › ',
  snippy = '',
  spell = '暈',
  treesitter = '',
  warn = '',
}

local colorschemes = {
  light = { bg = 'light', flavour = 'latte' },
  dark = { bg = 'dark', flavour = 'mocha' },
}

local set_colorscheme = function(name, theme)
  theme = theme or {}
  local colorscheme = colorschemes[name]

  vim.opt.background = colorscheme.bg
  vim.g.catppuccin_flavour = colorscheme.flavour

  R('catppuccin').setup()
  vim.cmd('colorscheme catppuccin')

  local palette = require('catppuccin.palettes').get_palette(colorscheme.flavour)

  theme.colorscheme = 'catppuccin'
  theme.icons = icons
  theme.colors = vim.tbl_extend('keep', colors, palette)

  setmetatable(theme, {
    __index = function(_, key)
      return require('my.utils.highlights').get(key)
    end,
  })

  return theme
end

local colorscheme_from_terminal = function()
  local config = vim.env.HOME .. '/.config/kitty/themes/current.conf'
  local ttheme = vim.fn.resolve(config)
  local name = 'dark'

  if vim.fn.fnamemodify(ttheme, ':p:t:r') == 'light' then
    name = 'light'
  end

  return set_colorscheme(name)
end

local theme = colorscheme_from_terminal()

theme.set = function(name)
  set_colorscheme(name, theme)
end

return theme
