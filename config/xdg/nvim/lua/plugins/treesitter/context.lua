local theme = require('plugins.highlight.theme')
local hl = require('my.utils.highlights')

require('treesitter-context').setup()

hl.def('TreesitterContextBottom', {
  underdouble = true,
  special = theme.colors.overlay0,
})
