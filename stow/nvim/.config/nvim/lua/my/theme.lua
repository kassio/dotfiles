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

  vim.opt.background = background
  vim.g.catppuccin_flavour = vim.fn.fnamemodify(ttheme, ':t:r')
  colorscheme.setup()
  vim.cmd('colorscheme ' .. colorscheme.name)

  local colorscheme_colors = colorscheme.colors()
  return vim.tbl_deep_extend('force', opts, {
    background = background,
    colors = {
      background = colorscheme_colors.base,
      shadow = colorscheme_colors.surface0,
      highlight = colorscheme_colors.overlay2,
    },
  })
end

return setup({
  colorscheme = {
    name = 'catppuccin',
    colors = function()
      return require('catppuccin.palettes').get_palette()
    end,
    setup = function()
      require('catppuccin').setup()
    end,
  },
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
})
