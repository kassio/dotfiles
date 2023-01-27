local hbar = require('config.hbar.utils')

return {
  render = function()
    local bufnr = vim.api.nvim_get_current_buf()

    return string.format(
      ' %s ',
      table.concat({
        '%n',
        hbar.render_component('filename', { bufnr = bufnr, clickable = true }),
        '%=',
        '%3l:%-3c %3p%%',
      }, ' ')
    )
  end,
}
