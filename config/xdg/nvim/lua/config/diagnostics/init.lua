local diagnostic = vim.diagnostic

return {
  setup = function()
    require('config.diagnostics.keymaps').setup()

    local symbols = require('utils.symbols')

    diagnostic.config({
      virtual_text = {
        severity = diagnostic.severity.ERROR,
        virt_text_pos = 'right_align',
      },
      underline = {
        severity = diagnostic.severity.WARN,
      },
      severity_sort = true,
      float = {
        focusable = false,
        style = 'minimal',
        border = 'rounded',
        source = false,
        header = '',
        suffix = '',
        prefix = '',
        format = function(value)
          return string.format('%s: [%s] %s', value.source, value.code, value.message)
        end,
      },
      signs = {
        text = {
          [diagnostic.severity.ERROR] = symbols.diagnostics.error,
          [diagnostic.severity.WARN] = symbols.diagnostics.warn,
          [diagnostic.severity.INFO] = symbols.diagnostics.info,
          [diagnostic.severity.HINT] = symbols.diagnostics.hint,
        },
      },
    })
  end,
}
