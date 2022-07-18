local setup = function(opts)
  local config = vim.env.HOME .. '/.config/kitty/themes/current.conf'
  local ttheme = vim.fn.resolve(config)
  local colorscheme = opts.colorscheme
  local background

  if vim.fn.fnamemodify(ttheme, ':p:h:t') == 'light' then
    background = 'light'
  else
    background = 'dark'
  end

  colorscheme.setup()
  vim.g.catppuccin_flavour = vim.fn.fnamemodify(ttheme, ':t:r')
  vim.cmd('colorscheme ' .. colorscheme.name)
  vim.opt.background = background

  return vim.tbl_deep_extend('force', opts, {
    background = background,
    colors = {
      background = colorscheme.colors.base,
      shadow = colorscheme.colors.surface0,
      highlight = colorscheme.colors.overlay2,
    },
  })
end

return setup({
  colorscheme = {
    name = 'catppuccin',
    colors = require('catppuccin.palettes').get_palette(),
    setup = function()
      require('catppuccin').setup()
    end,
  },
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
    separator = ' › ',
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
})
