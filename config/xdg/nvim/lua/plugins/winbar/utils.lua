local utils = require('my.utils')

return {
  render = function()
    local ft = vim.bo.filetype

    if ft == '' or utils.plugin_filetype(ft) then
      return ''
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local icon, hl_icon = utils.buffers.fileicon(bufnr)
    local hl = 'Winbar'

    if tonumber(vim.g.actual_curbuf) ~= tonumber(bufnr) then
      hl = 'WinbarNC'
      hl_icon = 'WinbarNC'
    end

    local winbar = table.concat({
      string.format('%%#%s#', hl),
      '%=',
      string.format('%%#%s#%s%%*', hl_icon, icon),
      ' %f',
      ' %n',
      '%=',
    }, '')

    return winbar
  end,
}
