local render_component = function(name)
  local component = require('plugins.statusline.components.' .. name)
  local ok, msg = pcall(component.render)

  if not ok then
    return ''
  end

  return msg
end

return {
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
