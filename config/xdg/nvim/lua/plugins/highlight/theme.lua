local setTheme = function(bg, flavor)
  vim.opt.background = bg
  vim.g.catppuccin_flavour = flavor

  require('catppuccin').setup()
  vim.cmd('colorscheme catppuccin')

  return {
    name = 'catppuccin',
    palettes = require('catppuccin.palettes').get_palette(),
  }
end

local setDarkTheme = function()
  return setTheme('dark', 'mocha')
end

local setLightTheme = function()
  return setTheme('light', 'latte')
end

local colorscheme_loader = function()
  local config = vim.env.HOME .. '/.config/kitty/themes/current.conf'
  local ttheme = vim.fn.resolve(config)

  if vim.fn.fnamemodify(ttheme, ':p:h:t') == 'light' then
    return setLightTheme()
  end

  return setDarkTheme()
end

local colorscheme = colorscheme_loader()
local theme = {
  colorscheme = colorscheme,
  icons = {
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
  },
  colors = {
    error = '#CA1243',
    warn = '#F7C154',
    info = '#6699CC',
    hint = '#50A14F',
    light_error = '#FD83A1',
    light_warn = '#FFF4A8',
    light_info = '#A5D0FF',
    light_hint = '#B5E6CE',
  },
  setLightTheme = setLightTheme,
  setDarkTheme = setDarkTheme,
}

setmetatable(theme, {
  __index = function(_, key)
    return require('my.utils.highlights').get(key)
  end,
})

return theme
