local devicons = require('nvim-web-devicons')
local icons = devicons.get_icons()

devicons.setup({
  override = {
    ruby = icons['rb'],
    go = icons['go'],
    sh = icons['sh'],
    bash = icons['bash'],
    zsh = icons['zsh'],
  },
})
