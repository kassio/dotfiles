return {
  {
    'folke/noice.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('noice').setup({
        routes = {
          {
            filter = {
              event = 'msg_show',
              kind = 'search_count',
            },
            opts = { skip = true },
          },
        },
        views = {
          cmdline_popup = {
            position = {
              row = 3,
              col = '50%',
            },
            size = {
              width = 60,
              height = 'auto',
            },
          },
          popupmenu = {
            relative = 'editor',
            position = {
              row = 3,
              col = '50%',
            },
            size = {
              width = 60,
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
