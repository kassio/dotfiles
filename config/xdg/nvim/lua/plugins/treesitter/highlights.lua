local hl = require('utils.highlights')

-- Treesitter globals
hl.extend('TSTypeBuiltin', 'Type')
hl.extend('TSVariable', 'Normal')
hl.extend('TSParameter', 'Normal')
hl.extend('TSFuncBuiltin', 'Identifier')
hl.extend('TSStringEscape', 'String', { bold = true })
hl.extend('TSStringSpecial', 'String', { bold = true })

-- refactoring
hl.def('TSDefinition', {
  underdotted = true,
  background = Theme.colors.mantle,
  special = Theme.colors.blue,
})
hl.extend('TSDefinitionUsage', 'TSDefinition')

-- Ruby with Treesitter
hl.extend('rubyTSType', 'Type')
hl.extend('rubyTSLabel', 'Identifier')
hl.extend('rubyTSSymbol', 'Identifier')
hl.extend('rubyTSVariableBuiltin', 'Constant')

-- Go with Treesitter
hl.extend('goTSnamespace', 'Normal', { bold = true })
hl.extend('goTSvariable', 'Normal')
hl.extend('goTSfunction_name', 'Function')
hl.extend('goTSproperty', 'Function')
