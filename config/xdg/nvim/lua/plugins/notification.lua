local notify = require('notify')
local theme = require('plugins.highlight.theme')

notify.setup({
  timeout = 1250,
  icons = {
    ERROR = theme.icons.error,
    WARN = theme.icons.warn,
    INFO = theme.icons.info,
    DEBUG = theme.icons.bug,
    TRACE = theme.icons.bug,
  },
  -- background_colour = theme['Normal'].background,
  on_open = function()
    vim.cmd('doautocmd User NotificationOpened')
  end,
  on_close = function()
    vim.cmd('doautocmd User NotificationClosed')
  end,
})

vim.notify = notify

vim.keymap.set('n', '<leader>nn', notify.dismiss)
