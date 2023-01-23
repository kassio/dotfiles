local hl = require('utils.highlights')

require('treesitter-context').setup()

hl.def('TreesitterContextBottom', {
  underdouble = true,
  special = Theme.colors.overlay0,
})
