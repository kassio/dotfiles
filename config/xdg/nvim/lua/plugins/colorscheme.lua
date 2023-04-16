return {
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
}
