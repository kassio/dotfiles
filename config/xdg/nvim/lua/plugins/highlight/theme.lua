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

local flavours = {
  light = 'latte',
  dark = 'mocha',
}

local set_colorscheme = function(background, theme)
  theme = theme or {}

  local flavour = flavours[background]

  vim.opt.background = background

  require('catppuccin').setup({
    flavour = flavour,
    background = {
      light = 'latte',
      dark = 'mocha',
    },
  })

  vim.cmd('colorscheme catppuccin')

  local palette = require('catppuccin.palettes').get_palette(flavour)

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

local theme
if vim.env.ITERM_PROFILE == 'light' then
  theme = set_colorscheme('light')
else
  theme = set_colorscheme('dark')
end

theme.set = function(name)
  set_colorscheme(name, theme)
end

return theme
