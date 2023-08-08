local api = vim.api
local utils = require('utils')

local git_hl = {
  added = 'Hint',
  changed = 'Warn',
  removed = 'Error',
}

local function hlname(name, focused)
  if not focused then
    return 'WinBarNC'
  end

  return 'Winbar.' .. name
end

local function count_limitter(counter, l)
  l = l or 99
  if counter > l then
    return '++'
  end

  return counter
end

local function get_filename(bufnr)
  local fullname = api.nvim_buf_get_name(bufnr)

  if #fullname == 0 then
    return ''
  else
    local name = vim.fn.fnamemodify(fullname, ':.')
    local limit = (vim.o.columns - 16)

    if #name > limit then
      local slash_limit = string.find(name, '/', #name - limit) or -1
      return '.../' .. string.sub(name, slash_limit + 1)
    end

    return name
  end
end

local function get_modified(bufnr)
  if api.nvim_buf_get_option(bufnr, 'modified') then
    return '∙'
  end

  return ''
end

local function get_todos(bufnr, focused)
  local signs = vim.fn.sign_getplaced(bufnr, { group = 'todo-signs' })[1].signs

  if #signs <= 0 then
    return ''
  end

  return string.format(
    '%%#%s#%s %s%%*',
    hlname('WinBar', focused),
    utils.symbols.todo,
    count_limitter(#signs)
  )
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
      '%%#%s#%s %s%%*',
      hlname(utils.string.camelcase(level), focused),
      utils.symbols.diagnostics[level],
      count_limitter(count)
    )
  end, vim.tbl_keys(utils.symbols.diagnostics))

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

    return string.format(
      '%%#%s#%s %s%%*',
      hlname(git_hl[name], focused),
      utils.symbols.git[name],
      count_limitter(count)
    )
  end, vim.tbl_keys(git_hl))

  statusList = vim.tbl_filter(function(e)
    return e ~= ''
  end, statusList)

  return table.concat(statusList, ' ')
end

local winbar = {}
winbar['neoterm'] = function()
  return 'neoterm-' .. vim.b.neoterm_id
end

winbar['help'] = function(bufnr)
  return 'help: ' .. vim.fn.fnamemodify(get_filename(bufnr), ':t')
end

winbar['NvimTree'] = function()
  return 'NvimTree'
end

setmetatable(winbar, {
  __index = function()
    return function(bufnr, focused)
      return string.format(
        ' %s ',
        table.concat({
          '%n',
          ' ',
          get_filename(bufnr),
          get_modified(bufnr),
          ' ',
          '%=',
          get_todos(bufnr, focused),
          ' ',
          get_diagnositcs(bufnr, focused),
          ' ',
          get_git_status(bufnr, focused),
        }, '')
      )
    end
  end,
})

return {
  render = function()
    local bufnr = api.nvim_get_current_buf()
    local focused = tonumber(api.nvim_get_current_win()) == tonumber(vim.g.actual_curwin)
    local filetype = vim.bo[bufnr].filetype

    vim.print({
      winbar,
      filetype,
      winbar[filetype],
    })

    local builder = winbar[filetype]

    return builder(bufnr, focused)
  end,
}
