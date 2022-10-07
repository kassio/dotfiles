local theme = require('plugins.highlight.theme')
local utils = require('my.utils')
local hl = utils.highlights

hl.def('WinbarNC', {
  background = theme.colors.base,
  foreground = theme.colors.surface1,
  special = theme.colors.surface1,
  underline = true,
})
hl.extend('Winbar', 'WinbarNC', {
  foreground = theme.colors.blue,
  special = theme.colors.blue,
  bold = true,
})

vim.opt.winbar = '%{%v:lua.require("plugins.winbar.utils").render()%}'
