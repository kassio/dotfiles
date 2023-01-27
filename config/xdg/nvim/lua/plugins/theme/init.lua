return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      local custom_highlights = require('plugins.theme.custom_highlights')

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
        custom_highlights = custom_highlights,
      })

      vim.cmd.colorscheme('catppuccin')
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
