return {
  { -- Custom dev icons
    'nvim-tree/nvim-web-devicons',
    config = function()
      local devicons = require('nvim-web-devicons')
      local icons = devicons.get_icons()

      local ext = function(source, target)
        vim.tbl_extend('force', icons[source], { name = target })
      end

      icons['rb'] = {
        icon = '',
        color = '#701516',
        cterm_color = '52',
        name = 'rb',
      }

      icons['Brewfile'] = ext('rb', 'Brewfile')
      icons['Gemfile$'] = ext('rb', 'gemspec')
      icons['config.ru'] = ext('rb', 'gemspec')
      icons.bash = icons['bash']
      icons.gemspec = ext('rb', 'gemspec')
      icons.go = icons['go']
      icons.irbrc = ext('rb', 'irbrc')
      icons.pryrc = ext('rb', 'pryrc')
      icons.rake = ext('rb', 'rake')
      icons.rakefile = ext('rb', 'rakefile')
      icons.rb = icons['rb']
      icons.ruby = ext('rb', 'ruby')
      icons.sh = icons['sh']
      icons.zsh = icons['zsh']

      devicons.setup({ override = icons })
    end,
  },

  { -- Prettier qf/loc windows
    'yorickpeterse/nvim-pqf',
    config = true,
  },

  { -- notifications
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

  {
    'chentoast/marks.nvim',
    config = function()
      require('marks').setup({
        default_mappings = true,
        builtin_marks = { '.', '<', '>', '^' },
        cyclic = true,
        force_write_shada = false,
        refresh_interval = 250,
        sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
        excluded_filetypes = {},
      })
    end,
  },

  { -- vim.ui.input & vim.ui.select
    'stevearc/dressing.nvim',
    config = function()
      require('dressing').setup({
        input = {
          enabled = true,
          title_pos = 'center',
          relative = 'editor',
        },
        select = {
          enabled = true,
          title_pos = 'center',
          relative = 'editor',
        },
      })
    end,
  },
}
