local theme = require('plugins.highlight.theme')
local utils = require('my.utils')
local hl = utils.highlights

hl.def('WinbarNC', {
  foreground = theme.colors.surface1,
  background = theme.colors.base,
  underline = true,
})
hl.extend('Winbar', 'WinbarNC', {
  foreground = theme.colors.blue,
  special = theme.colors.blue,
  bold = true,
})

vim.opt.winbar = '%{%v:lua.require("plugins.winbar.utils").render()%}'
