local format_diagnostic = function(level)
  local count = vim.tbl_count(vim.diagnostic.get(0, {
    severity = vim.diagnostic.severity[string.upper(level)],
  }))

  if count == 0 then
    return ''
  end

  return string.format('%%#hbar.diagnostics.%s#%s%s', level, Theme.icons[level], count)
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

    return string.format(' %s %%*', values)
  end,
}
