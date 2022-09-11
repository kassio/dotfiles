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

return {
  render = function()
    local ft = vim.bo.filetype

    if ft == '' or utils.plugin_filetype(ft) then
      return ''
    end

    local bg_hl = 'Winbar'
    local bufnr = vim.api.nvim_get_current_buf()
    local name = get_name(bufnr)
    local icon, icon_hl = utils.buffers.fileicon_extend_hl(bufnr, bg_hl)

    if tonumber(vim.g.actual_curbuf) ~= tonumber(bufnr) then
      bg_hl = 'WinbarNC'
      icon_hl = 'WinbarNC'
    end

    local winbar = table.concat({
      string.format('%%#%s#', bg_hl),
      '%=',
      string.format('%%#%s#%s%%*', icon_hl, icon),
      name,
      '%n',
      '%=',
    }, ' ')

    return winbar
  end,
}
