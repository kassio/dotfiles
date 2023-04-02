local hl = require('utils.highlights')

local function todos()
  local bufnr = vim.api.nvim_get_current_buf()
  local signs = vim.fn.sign_getplaced(bufnr, { group = 'todo-signs' })[1].signs

  if #signs <= 0 then
    return ''
  end

  local icon = hl.get_sign_icon('todo')
  return icon .. #signs
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
