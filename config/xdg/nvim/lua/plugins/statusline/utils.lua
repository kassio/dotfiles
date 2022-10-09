local utils = require('my.utils')

return {
  highlight = function(color)
    return string.format('%%#%s#', color)
  end,
  render = function()
    return table.concat({
      require('plugins.statusline.components.mode').render(),
      require('plugins.statusline.components.diagnostics').render(),
      ' ',
      utils.treesitter.location(),
      '%=',
      require('plugins.statusline.components.ui').render(),
      ' ',
      require('plugins.statusline.components.git-status').render(),
      require('plugins.statusline.components.git-branch').render(),
    }, '')
  end,
}
