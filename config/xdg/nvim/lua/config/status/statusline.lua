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
      mode(),
      git_branch(),
      '%=',
      '%S',
      vim.g.macromsg,
      search_count(),
      '%3l:%-3c %3p%%',
    })

    return string.format('%s', table.concat(components, ' '))
  end,
}
