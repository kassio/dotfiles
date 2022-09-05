local hl = require('my.utils.highlights')
local theme = require('plugins.highlight.theme')

hl.def('TabLine', {
  background = theme['NormalNC'].background,
  foreground = theme['NormalNC'].foreground,
  bold = false,
})
hl.extend('TabLineFill', 'TabLine')
hl.def('TabLineSel', {
  background = theme['Normal'].background,
  foreground = theme['Normal'].foreground,
  bold = true,
})

vim.opt.tabline = '%!v:lua.require("plugins.tabline.utils").render()'
