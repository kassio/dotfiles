local labels = {
  added = '+',
  removed = '-',
  changed = '~',
}

local format_gitstatus = function(counters, name)
  local count = tonumber(counters[name]) or 0

  if count == 0 then
    return ''
  end

  return string.format('%s%d', labels[name], count)
end

return {
  render = function()
    local dict = vim.b['gitsigns_status_dict'] or {}
    local statuses = vim.tbl_filter(function(e)
      return e ~= ''
    end, {
      format_gitstatus(dict, 'added'),
      format_gitstatus(dict, 'changed'),
      format_gitstatus(dict, 'removed'),
    })

    local values = table.concat(statuses, ' ')

    if values == '' then
      return ''
    end

    return string.format(' %s %%*', values)
  end,
}
