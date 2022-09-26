local hl = require('my.utils.highlights')
local theme = require('plugins.highlight.theme')

hl.def('TabLine', {
  foreground = theme.colors.surface2,
  background = theme.colors.surface0,
})
hl.extend('TabLineFill', 'TabLine')
hl.extend('TabLineSel', 'TabLine', {
  foreground = theme.colors.blue,
  background = theme.colors.base,
  bold = true,
})

vim.opt.tabline = '%!v:lua.require("plugins.tabline.utils").render()'
