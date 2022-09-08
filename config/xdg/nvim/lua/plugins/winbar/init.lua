local hl = require('my.utils.highlights')

hl.extend('Winbar', 'TablineSel')
hl.extend('WinbarNC', 'Tabline')

vim.opt.winbar = '%{%v:lua.require("plugins.winbar.utils").render()%}'
