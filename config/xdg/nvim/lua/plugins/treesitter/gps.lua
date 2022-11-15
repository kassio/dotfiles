local theme = require('plugins.highlight.theme')
local utils = require('my.utils')
local gps = require('nvim-gps')

gps.setup({
  separator = theme.icons.separator,
  icons = {
    ['class-name'] = ' ',
    ['container-name'] = ' ',
    ['function-name'] = ' ',
    ['method-name'] = ' ',
    ['tag-name'] = ' ',
  },
  languages = {
    ruby = {
      icons = {
        ['class-name'] = '::',
        ['container-name'] = '::',
        ['function-name'] = '.',
        ['method-name'] = '#',
        ['tag-name'] = '',
      },
      separator = '',
    },
  },
})

vim.api.nvim_create_user_command('TSGPSLocation', function()
  print(utils.treesitter.location())
end, {})

vim.api.nvim_create_user_command('TSGPSLocationCopy', function(cmd)
  utils.to_clipboard(utils.treesitter.location(), cmd.bang)
end, {})
