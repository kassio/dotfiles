local hl = require('utils.highlights')
local git_labels = {
  added = { icon = '+', hl = 'Hint' },
  changed = { icon = '~', hl = 'Warn' },
  removed = { icon = '-', hl = 'Error' },
}

local function hlname(name, focused)
  if not focused then
    return 'WinBarNC'
  end

  return name
end

local function get_todos(bufnr, focused)
  local signs = vim.fn.sign_getplaced(bufnr, { group = 'todo-signs' })[1].signs

  if #signs <= 0 then
    return ''
  end

  local icon = hl.get_sign_icon('todo')

  return string.format('%%#%s#%s%s%%*', hlname('WinBar', focused), icon, #signs)
end

local function get_diagnositcs(bufnr, focused)
  local diagnosticList = vim.tbl_map(function(level)
    local count = vim.tbl_count(vim.diagnostic.get(bufnr, {
      severity = vim.diagnostic.severity[string.upper(level)],
    }))

    if count == 0 then
      return ''
    end

    return string.format(
      '%%#%s#%s%s%%*',
      hlname(string.camelcase(level), focused),
      hl.get_sign_icon(level),
      count
    )
  end, { 'error', 'warn', 'info', 'hint' })

  diagnosticList = vim.tbl_filter(function(e)
    return e ~= ''
  end, diagnosticList)

  return table.concat(diagnosticList, ' ')
end

local function get_git_status(bufnr, focused)
  local counters = vim.b[bufnr]['gitsigns_status_dict'] or {}

  local statusList = vim.tbl_map(function(name)
    local count = tonumber(counters[name]) or 0

    if count == 0 then
      return ''
    end

    local label = git_labels[name]

    return string.format('%%#%s#%s%d%%*', hlname(label.hl, focused), label.icon, count)
  end, { 'added', 'changed', 'removed' })

  statusList = vim.tbl_filter(function(e)
    return e ~= ''
  end, statusList)

  return table.concat(statusList, ' ')
end

return {
  render = function()
    local focused = tonumber(vim.api.nvim_get_current_win()) == tonumber(vim.g.actual_curwin)
    local bufnr = vim.api.nvim_get_current_buf()

    return string.format(
      ' %s ',
      table.concat({
        '%n',
        '%f',
        '%m',
        '%=',
        get_todos(bufnr, focused),
        get_diagnositcs(bufnr, focused),
        get_git_status(bufnr, focused),
      }, ' ')
    )
  end,
}
