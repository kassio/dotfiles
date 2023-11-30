local utils = require('utils')

local def_sign = utils.highlights.def_sign

for name, symbol in pairs(utils.symbols.diagnostics) do
  def_sign(name, symbol)

  def_sign('DiagnosticSign' .. utils.string.camelcase(name), symbol)
end
