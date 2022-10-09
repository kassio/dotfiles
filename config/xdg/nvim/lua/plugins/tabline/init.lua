local hl = require('my.utils.highlights')
local colors = require('plugins.highlight.theme').colors

hl.def('TabLineFill', { background = colors.surface1 })
hl.def('TabLine', {
  foreground = colors.surface2,
  background = colors.surface0,
})
hl.def('TabLineSel', {
  foreground = colors.blue,
  background = colors.base,
  bold = true,
})

R('plugins.tabline.utils')
vim.opt.tabline = '%!v:lua.require("plugins.tabline.utils").render()'
