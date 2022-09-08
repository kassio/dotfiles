local hl = require('my.utils.highlights')

hl.extend('Winbar', 'TablineSel', { underline = false })
hl.extend('WinbarNC', 'Tabline', { underline = false })

vim.opt.winbar = '%{%v:lua.require("plugins.winbar.utils").render()%}'
