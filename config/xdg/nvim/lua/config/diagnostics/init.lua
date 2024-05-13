local diagnostic = vim.diagnostic

return {
  setup = function()
    require('config.diagnostics.keymaps').setup()

    diagnostic.config({
      virtual_text = {
        severity = diagnostic.severity.ERROR,
        spacing = 8,
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
    })
  end,
}
