local utils = require('utils')
local hl = require('config.hbar.utils').highlighter('Statusline', 'Git')

utils.highlights.extend('Statusline.Git', 'Theme.Surface0.Background', { bold = true })
utils.highlights.extend('Statusline.Git.Added', 'Statusline.Git', { foreground = Theme.colors.hint })
utils.highlights.extend(
  'Statusline.Git.Removed',
  'Statusline.Git',
  { foreground = Theme.colors.error }
)
utils.highlights.extend(
  'Statusline.Git.Changed',
  'Statusline.Git',
  { foreground = Theme.colors.warn }
)

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

  return string.format('%s%s%d', hl(name), labels[name], count)
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

    return string.format('%s %s %%*', hl(), values)
  end,
}