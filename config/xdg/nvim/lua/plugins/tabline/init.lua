local hl = require('my.utils.highlights')
local colors = require('plugins.highlight.theme').colors

hl.def('TabLine', { background = colors.dark_highlight, foreground = colors.highlight })
hl.extend('TabLineSel', 'TabLine', { foreground = colors.info, bold = true })
hl.extend('TabLineFill', 'TabLine')

vim.opt.tabline = '%!v:lua.require("plugins.tabline.utils").render()'
