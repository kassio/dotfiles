return {
  highlight = function(...)
    local opts = { ... }

    table.insert(opts, 1, 'Statusline')

    return string.format('%%#%s#', table.concat(opts, '.'))
  end,
  render = function()
    return table.concat({
      require('plugins.statusline.components.mode').render(),
      require('plugins.statusline.components.diagnostics').render(),
      require('plugins.statusline.components.code-location').render(),
      '%=',
      require('plugins.statusline.components.ui').render(),
      require('plugins.statusline.components.git-status').render(),
      '%<', -- truncate branch name if stautsline is too long
      require('plugins.statusline.components.git-branch').render(),
    }, '')
  end,
}
