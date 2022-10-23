local render_component = function(name)
  local component = require('plugins.statusline.components.' .. name)
  local ok, msg = pcall(component.render)

  if ok then
    return msg
  else
    P(msg)
    return ''
  end
end

return {
  highlight = function(...)
    local opts = { ... }

    table.insert(opts, 1, 'Statusline')

    return string.format('%%#%s#', table.concat(opts, '.'))
  end,
  render = function()
    return table.concat({
      render_component('mode'),
      render_component('diagnostics'),
      render_component('code-location'),
      '%=',
      render_component('ui'),
      render_component('git-status'),
      '%<', -- truncate branch name if stautsline is too long
      render_component('git-branch'),
    }, '')
  end,
}
