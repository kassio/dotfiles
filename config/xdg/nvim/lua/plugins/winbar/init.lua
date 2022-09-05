local hl = require('my.utils.highlights')
local theme = require('plugins.highlight.theme')

hl.def('Winbar', {
  background = theme['Normal'].background,
  foreground = theme['Normal'].foreground,
  bold = true,
})
hl.def('WinbarNC', {
  background = theme['NormalNC'].background,
  foreground = theme['NormalNC'].foreground,
  bold = false,
})

vim.opt.winbar = '%{%v:lua.require("plugins.winbar.utils").render()%}'
