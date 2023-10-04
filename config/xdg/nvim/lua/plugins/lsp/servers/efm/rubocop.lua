local fs = require('efmls-configs.fs')
local rubocop = require('efmls-configs.linters.rubocop')
local cmd = fs.executable('rubocop', fs.Scope.BUNDLE)

return vim.tbl_extend('force', rubocop, {
  lintCommand = string.format('%s --format emacs --stdin "${INPUT}"', cmd),
  lintCategoryMap = {
    A = 'H', -- autocorrect
    C = 'I', -- convention
    E = 'E', -- error
    F = 'E', -- fatal
    I = 'I', -- info
    R = 'H', -- refactor
    W = 'W', -- warning
  },
})
