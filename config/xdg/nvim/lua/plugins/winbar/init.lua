local hl = require('my.utils.highlights')

hl.extend('WinbarNC', 'StatusLine')
hl.extend('Winbar', 'WinbarNC', { bold = true })

vim.opt.winbar = '%{%v:lua.require("plugins.winbar.utils").render()%}'
