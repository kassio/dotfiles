return {
  -- vim.ui.input & vim.ui.select
  {
    'stevearc/dressing.nvim',
    config = function()
      require('dressing').setup({
        input = {
          enabled = true,
          title_pos = 'center',
          anchor = 'NW',
          relative = 'editor',
        },
        select = { enabled = true },
      })
    end,
  },

  -- notifications
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

      vim.keymap.set('n', '<leader>nn', notify.dismiss, { desc = 'notification: dismiss' })
    end,
  },

  -- Highlight color strings
  {
    'NvChad/nvim-colorizer.lua',
    config = true,
  },

  -- Prettier qf/loc windows
  {
    'https://gitlab.com/yorickpeterse/nvim-pqf.git',
    config = true,
  },
}
