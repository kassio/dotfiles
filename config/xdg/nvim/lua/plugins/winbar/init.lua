local hl = require('my.utils.highlights')
local colors = require('plugins.highlight.theme').colors

hl.def('Winbar', {
  background = colors.dark_highlight,
  foreground = colors.highlight,
  bold = true,
})
hl.extend('WinbarNC', 'Winbar', { bold = false })

vim.opt.winbar = '%{%v:lua.require("plugins.winbar.utils").render()%}'
