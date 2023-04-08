local mode_map = {
  [''] = 'V',
  ['!'] = '!',
  ['R'] = 'R',
  ['Rc'] = 'R',
  ['Rv'] = 'R',
  ['Rx'] = 'R',
  ['S'] = 'S',
  ['V'] = 'V',
  ['\22'] = 'V',
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

local mode_hl = {
  ['!'] = 'Hint.Light.Bg',
  ['?'] = 'Warn.Bg',
  ['C'] = 'Hint.Light.Bg',
  ['E'] = 'Hint.Light.Bg',
  ['I'] = 'Error.Bg',
  ['M'] = 'Warn.Bg',
  ['N'] = 'Info.Bg',
  ['O'] = 'Warn.Bg',
  ['R'] = 'Error.Light.Bg',
  ['S'] = 'Warn.Bg',
  ['T'] = 'Hint.Bg',
  ['V'] = 'Warn.Bg',
}

local function get_mode()
  local key = tostring(vim.api.nvim_get_mode().mode)
  local value = mode_map[key]

  if value == nil then
    return key
  end

  local hl = mode_hl[value]

  return string.format('%%#%s# %s %%*', hl, value), hl
end

local function get_search_count()
  if vim.v.hlsearch == 0 then
    return ''
  end

  local maxcount = 999
  local term = vim.fn.getreg('/')
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

local function get_git_branch(hl)
  local branch = vim.g['gitsigns_head']

  if branch == nil then
    return ''
  end

  return string.format('%%#%s#  %s %%*', hl, branch)
end

return {
  render = function()
    local mode, hl = get_mode()

    local components = vim.tbl_filter(function(value)
      return value ~= ''
    end, {
      mode,
      vim.g.macromsg,
      get_search_count(),
      '%=',
      '%S',
      '%3l:%-3c %3p%%',
      get_git_branch(hl),
    })

    return string.format('%s', table.concat(components, ' '))
  end,
}
