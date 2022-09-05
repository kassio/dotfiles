local hl = require('my.utils.highlights')
local theme = require('plugins.highlight.theme')

hl.def('Winbar', vim.tbl_extend('keep', theme.StatusLine, { bold = true }))
hl.def('WinbarNC', theme.StatusLine)

vim.opt.winbar = '%{%v:lua.require("plugins.winbar.utils").render()%}'
