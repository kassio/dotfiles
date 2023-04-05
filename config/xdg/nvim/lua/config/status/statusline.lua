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

  return string.format('%s', mode_map[mode_code])
end

local function diagnositcs()
  local diagnosticList = vim.tbl_map(function(level)
    local count = vim.tbl_count(vim.diagnostic.get(0, {
      severity = vim.diagnostic.severity[string.upper(level)],
    }))

    if count == 0 then
      return ''
    end

    return string.format('%%#%s#%s%s%%*', string.camelcase(level), hl.get_sign_icon(level), count)
  end, { 'error', 'warn', 'info', 'hint' })

  diagnosticList = vim.tbl_filter(function(e)
    return e ~= ''
  end, diagnosticList)

  return table.concat(diagnosticList, ' ')
end

local function git_status()
  local counters = vim.b['gitsigns_status_dict'] or {}

  local labels = {
    added = { icon = '+', hl = 'Hint' },
    changed = { icon = '~', hl = 'Warn' },
    removed = { icon = '-', hl = 'Error' },
  }

  local statusList = vim.tbl_map(function(name)
    local count = tonumber(counters[name]) or 0

    if count == 0 then
      return ''
    end

    local label = labels[name]

    return string.format('%%#%s#%s%d%%*', label.hl, label.icon, count)
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

  return string.format(' %s', branch)
end

local function search_count()
  if vim.v.hlsearch == 0 then
    return ''
  end

  local maxcount = 999
  local term = vim.fn.getreg('@')
  local result = vim.fn.searchcount({ maxcount = maxcount, timeout = 500 })
  local current = result.current
  local total = result.total

  if total > result.maxcount then
    total = '>' .. maxcount
  end

  if result.incomplete == 1 then
    total = '??'
  end

  return string.format('/%s [%s/%s]', term, current, total)
end

return {
  render = function()
    local components = vim.tbl_filter(function(value)
      return value ~= ''
    end, {
      '%#StatusLine#',
      mode(),
      diagnositcs(),
      '%=',
      '%S',
      vim.g.macromsg,
      search_count(),
      git_status(),
      git_branch(),
    })

    return string.format('%s', table.concat(components, ' '))
  end,
}
