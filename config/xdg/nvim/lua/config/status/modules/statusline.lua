local utils = require('utils')
local SEP = '│'

local mode_map = {
  [''] = 'V',
  ['!'] = '!',
  ['R'] = 'R',
  ['Rc'] = 'R',
  ['Rv'] = 'R',
  ['Rx'] = 'R',
  ['S'] = 'V',
  ['V'] = 'V',
  ['\22'] = 'V',
  ['c'] = 'C',
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
  ['s'] = 'V',
  ['t'] = 'T',
  ['v'] = 'V',
}

local mode_hl = {
  ['!'] = 'Statusline.Terminal',
  ['?'] = 'Statusline.Search',
  ['C'] = 'Statusline.Terminal',
  ['I'] = 'Statusline.Insert',
  ['N'] = 'Statusline.Normal',
  ['O'] = 'Statusline.Command',
  ['R'] = 'Statusline.Replace',
  ['T'] = 'Statusline.Terminal',
  ['V'] = 'Statusline.Visual',
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
  local ok, result = pcall(vim.fn.searchcount, { maxcount = maxcount, timeout = 500 })
  if not ok then
    result = result or {}
  end
  local current = result.current or 0
  local total_count = result.total or 0
  local total = tostring(total_count)

  if total_count > (result.maxcount or 0) then
    total = '>' .. maxcount
  end

  if result.incomplete == 1 then
    total = '??'
  end

  return string.format('/%s [%s/%s] %s', term, current, total, SEP)
end

local function get_git_branch(hl)
  local branch = vim.g['gitsigns_head']

  if branch == nil then
    return ''
  end

  return string.format('%%#%s#  %s %%*', hl, branch)
end

local function macromsg()
  local msg = vim.g.macromsg

  if (msg or '') ~= '' then
    return SEP .. ' ' .. msg
  end

  return ''
end

local function get_treesitter_location()
  local ft = vim.bo.filetype or ''
  if ft == '' or utils.plugin_filetype(ft) then
    return ''
  end

  return require('plugins.treesitter.fetcher').fetch()
end

return {
  render = function()
    local mode, hl = get_mode()

    return vim
      .iter({
        mode,
        get_treesitter_location(),
        macromsg(),
        '%=',
        '%S',
        SEP,
        get_search_count(),
        '%3l:%-3c' .. SEP .. ' %3p%%',
        get_git_branch(hl),
      })
      :filter(function(value)
        return value ~= ''
      end)
      :join(' ')
  end,
}
