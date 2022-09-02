local utils = require('my.utils')

return {
  render = function()
    local ft = vim.bo.filetype

    if ft == '' or utils.plugin_filetype(ft) then
      return ''
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local icon, icolor = utils.buffers.fileicon(bufnr)

    local winbar = table.concat({
      string.format('%%#%s#', 'Winbar'),
      '%=',
      string.format('%%#%s#%s%%*', icolor, icon),
      ' %f',
      ' %n',
      '%=',
    }, '')

    return winbar
  end,
}
