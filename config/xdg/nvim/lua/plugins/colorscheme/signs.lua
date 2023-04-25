return {
  setup = function()
    local symbols = require('utils.symbols')
    local def_sign = require('utils.highlights').def_sign

    for name, symbol in pairs(symbols.diagnostics) do
      def_sign(name, symbol)

      def_sign('DiagnosticSign' .. string.camelcase(name), symbol)
    end

    for name, symbol in pairs(symbols.debugger) do
      def_sign(name, symbol)
    end
  end,
}
