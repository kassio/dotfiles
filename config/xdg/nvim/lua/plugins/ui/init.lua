return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function()
      require('catppuccin').setup({
        flavour = 'latte',
        bg = {
          light = 'latte',
          dark = 'frappe',
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

  -- vim.ui.input & vim.ui.select
  {
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
