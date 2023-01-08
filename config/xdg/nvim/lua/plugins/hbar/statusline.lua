local render_component = require('plugins.hbar.utils').render_component

return {
  render = function()
    return table.concat({
      render_component('mode'),
      render_component('diagnostics'),
      render_component('code-location'),
      '%=',
      render_component('git-status'),
      '%<', -- truncate branch name if stautsline is too long
      render_component('git-branch'),
    }, '')
  end,
}
