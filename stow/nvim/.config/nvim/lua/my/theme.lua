local setup = function()
  local config = vim.env.HOME .. '/.config/kitty/themes/current.conf'
  local ttheme = vim.fn.resolve(config)

  vim.g.catppuccin_flavour = vim.fn.fnamemodify(ttheme, ':t:r')

  if vim.fn.fnamemodify(ttheme, ':p:h:t') == 'light' then
    vim.opt.background = 'light'
  else
    vim.opt.background = 'dark'
  end

  vim.cmd('colorscheme catppuccin')
end

setup()

local colorscheme = require('catppuccin.api.colors').get_colors()
local M = {
  reload = setup,
  -- Generic values (independent of the background)
  signs = {
    error = '',
    warn = '',
    hint = '',
    info = '',
    bug = '',
  },
  icons = {
    buffer = '',
    snippy = '',
    nvim_lsp = '',
    nvim_lua = '',
    path = 'פּ',
    spell = '暈',
    treesitter = '',
  },
  colors = {
    background = colorscheme.base,
    shadow = colorscheme.surface0,
    highlight = colorscheme.overlay2,
    error = '#CA1243',
    warn = '#F7C154',
    info = '#6699CC',
    hint = '#50A14F',
    light_error = '#FD83A1',
    light_warn = '#FFF4A8',
    light_info = '#A5D0FF',
    light_hint = '#B5E6CE',
  },
  -- Background dependent values
  dark = {
    statusline = 'nightfly',
  },
  light = {
    statusline = 'tomorrow',
  },
}

setmetatable(M, {
  __index = function(values, key)
    return values[vim.o.background][key]
  end,
})

return M
