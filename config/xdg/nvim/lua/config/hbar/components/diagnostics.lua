local utils = require('utils')
local hl = require('config.hbar.utils').highlighter('Statusline', 'Diagnostic')

local extend_diagnostic_hl = function(target, ext)
  return utils.highlights.extend('Statusline.Diagnostic.' .. target, 'Statusline.Diagnostic', ext)
end

utils.highlights.extend('Statusline.Diagnostic', 'Theme.Surface0.Background', { bold = true })
extend_diagnostic_hl('Hint', { foreground = Theme.colors.hint })
extend_diagnostic_hl('Info', { foreground = Theme.colors.info })
extend_diagnostic_hl('Warn', { foreground = Theme.colors.warn })
extend_diagnostic_hl('Error', { foreground = Theme.colors.error })

local format_diagnostic = function(level)
  local count = vim.tbl_count(vim.diagnostic.get(0, {
    severity = vim.diagnostic.severity[string.upper(level)],
  }))

  if count == 0 then
    return ''
  end

  return string.format('%s%s%s', hl(level), Theme.icons[level], count)
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

    return string.format('%s %s %%*', hl(), values)
  end,
}
