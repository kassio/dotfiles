local utils = require('utils')

return {
  setup = function()
    local def_sign = utils.highlights.def_sign

    for name, symbol in pairs(utils.symbols.diagnostics) do
      def_sign(name, symbol)

      def_sign('DiagnosticSign' .. utils.string.camelcase(name), symbol)
    end

    for name, symbol in pairs(utils.symbols.debugger) do
      def_sign(name, symbol)
    end
  end,
}
