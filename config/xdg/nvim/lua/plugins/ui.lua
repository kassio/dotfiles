vim.opt.cmdheight = 0

require('noice').setup({
  views = {
    cmdline_popup = {
      position = {
        row = 3,
        col = '50%',
      },
      size = {
        width = 80,
        height = 'auto',
      },
    },
    popupmenu = {
      relative = 'editor',
      position = {
        row = 6,
        col = '50.5%',
      },
      size = {
        width = 82,
        height = 10,
      },
      border = {
        style = 'rounded',
        padding = { 0, 1 },
      },
      win_options = {
        winhighlight = { Normal = 'Normal', FloatBorder = 'DiagnosticInfo' },
      },
    },
  },
  routes = {
    {
      view = 'split',
      filter = { event = 'msg_show', min_height = 3 },
    },
    {
      filter = {
        event = 'msg_show',
        kind = 'search_count',
      },
      opts = { skip = true },
    },
  },
})
