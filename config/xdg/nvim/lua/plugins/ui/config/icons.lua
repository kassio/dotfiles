local def_sign = require('utils.highlights').def_sign

return {
  setup = function()
    -- generic
    def_sign('error', '')
    def_sign('warn', '')
    def_sign('info', '')
    def_sign('hint', '')
    def_sign('todo', '')

    -- diagnostics
    def_sign('DiagnosticSignError', '')
    def_sign('DiagnosticSignWarn', '')
    def_sign('DiagnosticSignInfo', '')
    def_sign('DiagnosticSignHint', '')

    -- debugger
    def_sign('DapBreakpoint', '●')
    def_sign('DapBreakpointCondition', '◆')
    def_sign('DapLogPoint', 'Ξ')
    def_sign('DapStopped', '▶')
    def_sign('DapBreakpointRejected', '◎')
  end,
}
