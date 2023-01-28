return {
  {
    'rcarriga/nvim-notify',
    config = function()
      local notify = require('notify')

      notify.setup({
        timeout = 1250,
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
