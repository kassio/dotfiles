local sign = function(name, icon)
  vim.fn.sign_define(name, {
    text = icon,
    texthl = name,
  })
end

return {
  setup = function()
    -- debugger
    sign('DapBreakpoint', '●')
    sign('DapBreakpointCondition', '◆')
    sign('DapLogPoint', 'Ξ')
    sign('DapStopped', '▶')
    sign('DapBreakpointRejected', '◎')

    -- diagnostics
    sign('DiagnosticSignError', '')
    sign('DiagnosticSignWarn', '')
    sign('DiagnosticSignInfo', '')
    sign('DiagnosticSignHint', '')
  end,
}
