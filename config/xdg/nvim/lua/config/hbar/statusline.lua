local hbar = require('config.hbar.utils')

return {
  render = function()
    return table.concat({
      hbar.render_component('mode'),
      '%#hbar.section.b#',
      hbar.render_component('treesitter-location', { clickable = true }),
      hbar.render_component('diagnostics'),
      '%#hbar.section.c#',
      '%=',
      '%#hbar.section.b#',
      hbar.render_component('git-status'),
      '%<', -- truncate branch name if stautsline is too long
      '%#hbar.section.a#',
      hbar.render_component('git-branch', { clickable = true }),
    }, '')
  end,
}
