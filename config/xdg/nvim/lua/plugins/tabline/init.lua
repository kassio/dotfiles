local hl = require('my.utils.highlights')
local colors = require('plugins.highlight.theme').colors

hl.def('TabLine', { background = colors.dark_highlight, foreground = colors.highlight })
hl.extend('TabLineFill', 'TabLine')
hl.extend(
  'TabLineSel',
  'TabLine',
  { background = colors.info, foreground = colors.shadow, bold = true }
)

vim.opt.tabline = '%!v:lua.require("plugins.tabline.utils").tabline()'
