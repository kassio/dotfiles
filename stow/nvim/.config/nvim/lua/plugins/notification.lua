local notify = require('notify')
local theme = vim.my.theme

require('notify').setup({
  timeout = 1250,
  icons = {
    ERROR = theme.icons.error,
    WARN = theme.icons.warn,
    INFO = theme.icons.info,
    DEBUG = theme.icons.bug,
    TRACE = theme.icons.bug,
  },
  background_colour = theme.colors.background,
})

vim.notify = notify
