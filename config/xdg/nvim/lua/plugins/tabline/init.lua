local hl = require('my.utils.highlights')
local theme = require('plugins.highlight.theme')

hl.def('TabLine', { foreground = theme.colors.blue })
hl.extend('TabLineFill', 'TabLine')
hl.extend('TabLineSel', 'TabLine', { bold = true })

vim.opt.tabline = '%!v:lua.require("plugins.tabline.utils").render()'
