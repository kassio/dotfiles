local hl = require('my.utils.highlights')

hl.extend('TabLine', 'StatusLine')
hl.extend('TabLineFill', 'TabLine')
hl.extend('TabLineSel', 'TabLine', { bold = true })

vim.opt.tabline = '%!v:lua.require("plugins.tabline.utils").render()'
