return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function()
      require('catppuccin').setup({
        flavour = 'mocha',
        bg = {
          light = 'latte',
          dark = 'mocha',
        },
        color_overrides = {
          all = {
            error = '#CA1243',
            warn = '#F7C154',
            info = '#6699CC',
            hint = '#50A14F',
            error_light = '#FD83A1',
            warn_light = '#FFF4A8',
            info_light = '#A5D0FF',
            hint_light = '#B5E6CE',
          },
        },
        integrations = {
          cmp = true,
          mason = true,
          notify = true,
          nvimtree = true,
          telescope = true,
        },
        show_end_of_buffer = false,
        term_colors = false,
        custom_highlights = require('plugins.ui.colorscheme.highlights'),
      })

      vim.cmd.colorscheme('catppuccin')

      require('plugins.ui.colorscheme.signs').setup()
    end,
  },

  -- Custom dev icons
  {
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
}
