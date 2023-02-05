return {
  -- Theme
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      local highlights = require('plugins.ui.config.highlights')

      require('catppuccin').setup({
        opts = {
          flavour = 'mocha',
          bg = {
            light = 'latte',
            dark = 'mocha',
          },
          integrations = {
            cmp = true,
            gitsigns = true,
            nvimtree = true,
            telescope = true,
            notify = true,
            mason = true,
          },
        },
        custom_highlights = highlights,
      })

      vim.cmd.colorscheme('catppuccin')
    end,
  },

  -- Notifications
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

  -- Custom dev icons
  {
    'nvim-tree/nvim-web-devicons',
    priority = 999,
    config = function()
      require('plugins.ui.config.icons').setup()

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
}
