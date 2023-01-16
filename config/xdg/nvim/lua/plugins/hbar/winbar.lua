local hl = require('my.utils').highlights
local theme = require('plugins.highlight.theme')
local hbar = require('plugins.hbar.utils')

hl.def('WinbarNC', {
  background = theme.colors.base,
  foreground = theme.colors.surface1,
  special = theme.colors.surface1,
  underline = true,
})

hl.extend('Winbar', 'WinbarNC', {
  foreground = theme.colors.blue,
  special = theme.colors.blue,
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
