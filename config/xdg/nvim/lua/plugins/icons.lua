local devicons = require('nvim-web-devicons')
local icons = devicons.get_icons()

icons['rb'] = {
  icon = '',
  color = '#701516',
  cterm_color = '52',
  name = 'rb',
}

local ext = function(source, target)
  vim.tbl_extend('force', icons[source], { name = target })
end

devicons.setup({
  override = {
    rb = icons['rb'],
    ruby = ext('rb', 'ruby'),
    irbrc = ext('rb', 'irbrc'),
    pryrc = ext('rb', 'pryrc'),
    Brewfile = ext('rb', 'Brewfile'),
    go = icons['go'],
    sh = icons['sh'],
    bash = icons['bash'],
    zsh = icons['zsh'],
  },
})
