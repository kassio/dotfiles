local config = require('efmls-configs.linters.rubocop')
local fs = require('efmls-configs.fs')
local cmd = fs.executable('rubocop', fs.Scope.BUNDLE)

config.lintCommand = string.format('%s --format emacs --stdin "${INPUT}"', cmd)
config.lintCategoryMap = {
  A = 'H', -- autocorrect
  C = 'I', -- convention
  E = 'E', -- error
  F = 'E', -- fatal
  I = 'I', -- info
  R = 'H', -- refactor
  W = 'W', -- warning
}

return config
