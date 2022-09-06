local utils = require('my.utils')

return {
  render = function()
    local ft = vim.bo.filetype

    if ft == '' or utils.plugin_filetype(ft) then
      return ''
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local bg_hl = 'Winbar'

    if tonumber(vim.g.actual_curbuf) ~= tonumber(bufnr) then
      bg_hl = 'WinbarNC'
    end

    local icon, icon_hl = utils.buffers.fileicon_custom_bg(bufnr, bg_hl)

    local winbar = table.concat({
      string.format('%%#%s#', bg_hl),
      '%=',
      string.format('%%#%s#%s%%*', icon_hl, icon),
      ' %f',
      ' %n',
      '%=',
    }, '')

    return winbar
  end,
}
