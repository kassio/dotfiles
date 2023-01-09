local theme = require('plugins.highlight.theme')
local utils = require('my.utils')
local hl = utils.highlights

hl.def('TabLineFill', {
  background = theme.colors.surface1,
})

hl.def('TabLine', {
  foreground = theme.colors.surface2,
  background = theme.colors.surface0,
})

hl.def('TabLineSel', {
  foreground = theme.colors.blue,
  background = theme.colors.base,
  bold = true,
})

local renderer = function(name)
  return string.format('%%{%%v:lua.require("plugins.hbar.%s").render()%%}', name)
end

vim.opt.laststatus = 3
vim.opt.statusline = renderer('statusline')
vim.opt.tabline = renderer('tabline')
vim.opt.winbar = renderer('winbar')
