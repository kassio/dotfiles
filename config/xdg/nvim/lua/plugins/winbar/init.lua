local hl = require('my.utils.highlights')
local colors = require('plugins.highlight.theme').colors

hl.def('Winbar', {
  background = colors.dark_highlight,
  foreground = colors['Normal'].foreground,
  bold = true,
})
hl.def('WinbarNC', {
  background = colors.dark_highlight,
  foreground = colors.highlight,
  bold = false,
})

vim.opt.winbar = '%{%v:lua.require("plugins.winbar.utils").render()%}'
