local hbar = require('plugins.hbar.utils')

return {
  render = function()
    return table.concat({
      hbar.render_component('mode'),
      hbar.render_component('diagnostics'),
      hbar.render_component('code-location', { clickable = true }),
      '%=',
      hbar.render_component('git-status'),
      '%<', -- truncate branch name if stautsline is too long
      hbar.render_component('git-branch', { clickable = true }),
    }, '')
  end,
}
