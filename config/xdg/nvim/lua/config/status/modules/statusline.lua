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
  local result = vim.fn.searchcount({ maxcount = maxcount, timeout = 500 })
  local current = result.current
  local total = result.total

  if total > result.maxcount then
    total = '>' .. maxcount
  end

  if result.incomplete == 1 then
    total = '??'
  end

  return string.format('| /%s [%s/%s]', term, current, total)
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
    return '| ' .. msg
  end

  return ''
end

local function treesitter_context()
  return require('plugins.treesitter.fetcher').fetch(vim.b.treesitter_statusline_options)
end

local function explorer_filename()
  if vim.bo.filetype ~= 'NvimTree' then
    return ''
  end

  local node = require('nvim-tree.api').tree.get_node_under_cursor()
  if node == nil then
    return 'no nodes'
  end

  return vim.fs.basename(node.absolute_path)
end

local function explorer_filename()
  if vim.bo.filetype ~= 'NvimTree' then
    return ''
  end

  local node = require('nvim-tree.api').tree.get_node_under_cursor()
  if node == nil then
    return 'no nodes'
  end

  return vim.fs.basename(node.absolute_path)
end

return {
  render = function()
    local mode, hl = get_mode()

    local components = vim.tbl_filter(function(value)
      return value ~= ''
    end, {
      mode,
      explorer_filename(),
      treesitter_context(),
      macromsg(),
      '%=',
      '%S',
      get_search_count(),
      '%3l:%-3c %3p%%',
      get_git_branch(hl),
    })

    return string.format('%s', table.concat(components, ' '))
  end,
}
