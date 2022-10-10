local theme = require('plugins.highlight.theme')
local hl = require('my.utils.highlights')
local utils = require('plugins.statusline.utils')

hl.extend('Statusline.Diagnostic', 'Theme.Surface0.Background', { bold = true })
hl.extend('Statusline.Diagnostic.Hint', 'Statusline.Diagnostic', { foreground = theme.colors.hint })
hl.extend('Statusline.Diagnostic.Info', 'Statusline.Diagnostic', { foreground = theme.colors.info })
hl.extend('Statusline.Diagnostic.Warn', 'Statusline.Diagnostic', { foreground = theme.colors.warn })
hl.extend(
  'Statusline.Diagnostic.Error',
  'Statusline.Diagnostic',
  { foreground = theme.colors.error }
)

local format_diagnostic = function(level)
  local count = vim.tbl_count(vim.diagnostic.get(0, {
    severity = vim.diagnostic.severity[string.upper(level)],
  }))

  if count == 0 then
    return ''
  end

  return string.format('%s%s%s', utils.highlight('Diagnostic', level), theme.icons[level], count)
end

return {
  render = function()
    local diagnositcs = vim.tbl_filter(function(e)
      return e ~= ''
    end, {
      format_diagnostic('error'),
      format_diagnostic('warn'),
      format_diagnostic('info'),
      format_diagnostic('hint'),
    })

    local values = table.concat(diagnositcs, ' ')

    if values == '' then
      return ''
    end

    return string.format('%s %s %%*', utils.highlight('Diagnostic'), values)
  end,
}
