local theme = require('plugins.highlight.theme')
local hl = require('my.utils.highlights')
local utils = require('plugins.statusline.utils')

hl.extend('Statusline.Git', 'Theme.Surface0.Background', { bold = true })
hl.extend('Statusline.Git.Added', 'Statusline.Git', { foreground = theme.colors.hint })
hl.extend('Statusline.Git.Removed', 'Statusline.Git', { foreground = theme.colors.error })
hl.extend('Statusline.Git.Changed', 'Statusline.Git', { foreground = theme.colors.warn })

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

  return string.format('%s%s%d', utils.highlight('Git', name), labels[name], count)
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

    return string.format('%s %s %%*', utils.highlight('Git'), values)
  end,
}
