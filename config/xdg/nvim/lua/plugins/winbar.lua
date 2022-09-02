local utils = require('my.utils')

require('incline').setup({
  render = function(props)
    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':.')
    local icon, icolor = utils.buffers.fileicon_color(props.buf)

    return {
      { props.buf },
      { ' ' },
      { icon, guifg = icolor },
      { ' ' },
      { filename, guifg = '' },
    }
  end,
  ignore = {
    buftypes = 'special',
    filetypes = utils.plugin_filetypes,
    floating_wins = true,
    unlisted_buffers = true,
    wintypes = 'special',
  },
})
