return {
  -- Highlight color strings
  {
    'NvChad/nvim-colorizer.lua',
    opts = {
      user_default_options = {
        RGB = true,
        RRGGBB = true,
        names = false,
        RRGGBBAA = true,
        mode = 'background',
        always_update = false,
      },
    },
  },

  -- Fix terminal colors
  {
    'norcalli/nvim-terminal.lua',
    config = true,
  },
}
