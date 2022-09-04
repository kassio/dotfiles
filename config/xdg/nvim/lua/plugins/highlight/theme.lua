local colorscheme_loader = function()
  local config = vim.env.HOME .. '/.config/kitty/themes/current.conf'
  local ttheme = vim.fn.resolve(config)

  if vim.fn.fnamemodify(ttheme, ':p:h:t') == 'light' then
    vim.opt.background = 'light'
    vim.g.catppuccin_flavour = 'latte'
  else
    vim.opt.background = 'dark'
    vim.g.catppuccin_flavour = 'mocha'
  end

  require('catppuccin').setup()
  vim.cmd('colorscheme catppuccin')

  return {
    name = 'catppuccin',
    palettes = require('catppuccin.palettes').get_palette(),
  }
end

local colorscheme = colorscheme_loader()
local colors = {
  error = '#CA1243',
  warn = '#F7C154',
  info = '#6699CC',
  hint = '#50A14F',
  light_error = '#FD83A1',
  light_warn = '#FFF4A8',
  light_info = '#A5D0FF',
  light_hint = '#B5E6CE',
  background = colorscheme.palettes.base,
  shadow = colorscheme.palettes.surface0,
  highlight = colorscheme.palettes.overlay2,
  dark_highlight = colorscheme.palettes.mantle,
}

setmetatable(colors, {
  __index = function(_, key)
    local ok, color = require('my.utils.highlights').get(key)

    if ok then
      return color
    end
  end,
})

return {
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
  colors = colors,
}
