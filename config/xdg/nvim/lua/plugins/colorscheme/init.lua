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
