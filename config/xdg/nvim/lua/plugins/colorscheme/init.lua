return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
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
        custom_highlights = require('plugins.colorscheme.highlights'),
      })

      vim.cmd.colorscheme('catppuccin')

      require('plugins.colorscheme.signs').setup()
    end,
  },
}
