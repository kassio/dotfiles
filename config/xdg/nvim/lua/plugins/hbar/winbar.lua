local hl = require('utils').highlights
local hbar = require('plugins.hbar.utils')

hl.def('WinbarNC', {
  background = Theme.colors.base,
  foreground = Theme.colors.surface1,
  special = Theme.colors.surface1,
  underline = true,
})

hl.extend('Winbar', 'WinbarNC', {
  foreground = Theme.colors.blue,
  special = Theme.colors.blue,
  bold = true,
})

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
