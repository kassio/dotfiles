local hl = require('utils.highlights')

local function todos()
  local bufnr = vim.api.nvim_get_current_buf()
  local signs = vim.fn.sign_getplaced(bufnr, { group = 'todo-signs' })[1].signs
  local counters = {}

  for _, sign in ipairs(signs) do
    local icon = hl.get_sign_icon(sign.name)

    if counters[icon] == nil then
      counters[icon] = { icon = icon, total = 1 }
    else
      counters[icon].total = counters[icon].total + 1
    end
  end

  local list = vim.tbl_values(counters)
  table.sort(list, function(a, b)
    return a.total > b.total
  end)

  return vim.trim(vim.fn.reduce(list, function(result, counter)
    return string.format('%s %s%s', result, counter.icon, counter.total)
  end, ''))
end

return {
  render = function()
    return string.format(
      ' %s ',
      table.concat({
        '%n',
        '%f',
        '%=',
        todos(),
        '%3l:%-3c %3p%%',
      }, ' ')
    )
  end,
}
