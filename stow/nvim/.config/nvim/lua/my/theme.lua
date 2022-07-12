local setup = function(opts)
  local config = vim.env.HOME .. '/.config/kitty/themes/current.conf'
  local ttheme = vim.fn.resolve(config)
  local background

  if vim.fn.fnamemodify(ttheme, ':p:h:t') == 'light' then
    background = 'light'
  else
    background = 'dark'
  end

  require(opts.colorscheme).setup()
  vim.g.catppuccin_flavour = vim.fn.fnamemodify(ttheme, ':t:r')
  vim.cmd('colorscheme ' .. opts.colorscheme)
  vim.opt.background = background

  local colors = require(opts.colorscheme .. '.api.colors').get_colors()

  return vim.tbl_deep_extend('force', opts, {
    background = background,
    colors = {
      background = colors.base,
      shadow = colors.surface0,
      highlight = colors.overlay2,
    },
  })
end

return setup({
  colorscheme = 'catppuccin',
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
