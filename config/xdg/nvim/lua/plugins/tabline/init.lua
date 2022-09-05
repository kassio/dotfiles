local hl = require('my.utils.highlights')
local colors = require('plugins.highlight.theme').colors

hl.def('TabLine', {
  background = colors.dark_highlight,
  foreground = colors.highlight,
  bold = false,
})
hl.extend('TabLineFill', 'TabLine')
hl.def('TabLineSel', {
  background = colors.dark_highlight,
  foreground = colors['Normal'].foreground,
  bold = true,
})

vim.opt.tabline = '%!v:lua.require("plugins.tabline.utils").render()'
