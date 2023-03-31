local hl = require('utils.highlights')

local mode_map = {
  [''] = 'V',
  ['!'] = '!',
  ['R'] = 'R',
  ['Rc'] = 'R',
  ['Rv'] = 'R',
  ['Rx'] = 'R',
  ['S'] = 'S',
  ['V'] = 'V',
  ['c'] = 'C',
  ['ce'] = 'E',
  ['cv'] = 'E',
  ['i'] = 'I',
  ['ic'] = 'I',
  ['ix'] = 'I',
  ['n'] = 'N',
  ['niI'] = 'N',
  ['niR'] = 'N',
  ['niV'] = 'N',
  ['no'] = 'O',
  ['noV'] = 'O',
  ['nov'] = 'O',
  ['nt'] = 'N',
  ['r'] = 'R',
  ['r?'] = '?',
  ['rm'] = 'M',
  ['s'] = 'S',
  ['t'] = 'T',
  ['v'] = 'V',
}

local function mode()
  local mode_code = vim.api.nvim_get_mode().mode

  if mode_map[mode_code] == nil then
    return mode_code
  end

  return string.format('%%#Info#%s%%*', mode_map[mode_code])
end

local function diagnositcs()
  local diagnosticList = vim.tbl_map(function(level)
    local count = vim.tbl_count(vim.diagnostic.get(0, {
      severity = vim.diagnostic.severity[string.upper(level)],
    }))

    if count == 0 then
      return ''
    end

    return string.format('%%#%s#%s%s%%*', level, hl.get_sign_icon(level), count)
  end, { 'error', 'warn', 'info', 'hint' })

  diagnosticList = vim.tbl_filter(function(e)
    return e ~= ''
  end, diagnosticList)

  return table.concat(diagnosticList, ' ')
end

local function git_status()
  local counters = vim.b['gitsigns_status_dict'] or {}

  local labels = {
    added = '+',
    changed = '~',
    removed = '-',
  }

  local highlights = {
    added = 'Hint',
    changed = 'Warn',
    removed = 'Error',
  }

  local statusList = vim.tbl_map(function(name)
    local count = tonumber(counters[name]) or 0

    if count == 0 then
      return ''
    end

    return string.format('%%#%s#%s%d%%*', highlights[name], labels[name], count)
  end, { 'added', 'changed', 'removed' })

  statusList = vim.tbl_filter(function(e)
    return e ~= ''
  end, statusList)

  return table.concat(statusList, ' ')
end

local function git_branch()
  local branch = vim.g['gitsigns_head']

  if branch == nil then
    return ''
  end

  return string.format('%%#Info# %s%%*', branch)
end

return {
  render = function()
    local components = vim.tbl_filter(function(value)
      return value ~= ''
    end, {
      mode(),
      diagnositcs(),
      '%=',
      git_status(),
      '%<', -- truncate branch name if stautsline is too long
      git_branch(),
    })

    return string.format('%s', table.concat(components, ' '))
  end,
}
