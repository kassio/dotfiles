local hl = require('my.utils.highlights')
local theme = require('plugins.highlight.theme')

hl.def('TabLine', {
  foreground = theme.colors.surface1,
  background = theme.colors.mantle,
  special = theme.colors.blue,
  underline = true,
})
hl.extend('TabLineFill', 'TabLine')
hl.extend('TabLineSel', 'TabLine', {
  foreground = theme.colors.blue,
  bold = true,
})

vim.opt.tabline = '%!v:lua.require("plugins.tabline.utils").render()'
