local hl = require('my.utils.highlights')
local theme = require('plugins.highlight.theme')

hl.def('TabLine', theme.StatusLine)
hl.extend('TabLineFill', 'TabLine')
hl.def('TabLineSel', vim.tbl_extend('keep', theme.StatusLine, { bold = true }))

vim.opt.tabline = '%!v:lua.require("plugins.tabline.utils").render()'
