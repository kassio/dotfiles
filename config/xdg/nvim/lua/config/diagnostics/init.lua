local diagnostic = vim.diagnostic

return {
  setup = function()
    require('config.diagnostics.keymaps').setup()

    diagnostic.config({
      virtual_text = {
        severity = diagnostic.severity.ERROR,
        spacing = 8,
      },
      underline = true,
      severity_sort = true,
      float = {
        focusable = false,
        style = 'minimal',
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
        format = function(value)
          return string.format('%s [%s]\n%s', value.source, value.code, value.message)
        end,
      },
    })
  end,
}
