return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      local hl = require('utils.highlights')

      require('catppuccin').setup({
        opts = {
          flavour = 'mocha',
          background = {
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
        custom_highlights = function(colors)
          return {
            ['IncSearch'] = { fg = colors.base, bg = colors.yellow },
            ['Search'] = { fg = colors.base, bg = colors.yellow },
            ['CurSearch'] = { fg = colors.base, bg = colors.red, style = { 'italic', 'bold' } },
          }
        end,
      })

      vim.cmd.colorscheme('catppuccin')

      local pallete = require('catppuccin.palettes').get_palette()

      Theme.colors = vim.tbl_deep_extend('keep', Theme.colors, pallete)

      for name, value in pairs(Theme.colors) do
        hl.def(string.format('Theme.%s.Foreground', string.camelcase(name)), {
          foreground = value,
        })

        hl.def(string.format('Theme.%s.Background', string.camelcase(name)), {
          background = value,
        })
      end
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
