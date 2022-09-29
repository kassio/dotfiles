local utils = require('my.utils')

local get_name = function(bufnr)
  local fullname = vim.api.nvim_buf_get_name(bufnr)

  if #fullname == 0 then
    return '[No name]'
  else
    local name = vim.fn.fnamemodify(fullname, ':.')

    if #name > 70 then
      local parts = vim.split(name, '/')
      return '.../' .. table.concat(parts, '/', 2, #parts)
    end

    return name
  end
end

local highlight = function(label, color)
  return string.format('%%#%s#%s%%*', color, label)
end

return {
  render = function()
    local ft = vim.bo.filetype
    local winid = vim.api.nvim_get_current_win()

    if ft == '' or utils.plugin_filetype(ft) then
      return ''
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local name = get_name(bufnr)
    local hl = 'Winbar'

    if tonumber(vim.g.actual_curwin) ~= tonumber(winid) then
      hl = 'WinbarNC'
      icon_hl = 'WinbarNC'
    end

    local icon, icon_hl = utils.buffers.fileicon_extend_hl(bufnr, hl)

    return table.concat({
      highlight('%=', hl),
      highlight(icon, icon_hl),
      highlight(name, hl),
      highlight('%n', hl),
      highlight('%=', hl),
    }, ' ')
  end,
}
