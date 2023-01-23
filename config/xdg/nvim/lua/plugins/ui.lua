return {
  {
    'rcarriga/nvim-notify',
    config = function()
      local notify = require('notify')

      notify.setup({
        timeout = 1250,
        icons = {
          ERROR = Theme.icons.error,
          WARN = Theme.icons.warn,
          INFO = Theme.icons.info,
          DEBUG = Theme.icons.bug,
          TRACE = Theme.icons.bug,
        },
        on_open = function()
          vim.cmd('doautocmd User NotificationOpened')
        end,
        on_close = function()
          vim.cmd('doautocmd User NotificationClosed')
        end,
        top_down = false,
      })

      vim.notify = notify

      vim.keymap.set('n', '<leader>nn', notify.dismiss)
    end,
  },
}
