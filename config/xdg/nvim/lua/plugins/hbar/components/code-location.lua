local utils = require('my.utils')
local clickable = require('plugins.hbar.utils').clickable

return {
  on_click = function(_bufnr, _clicks, _button, mods)
    utils.to_clipboard(utils.treesitter.location(), vim.fn.stridx(mods, 'c') ~= -1)
  end,
  render = function()
    return string.format(
      ' %s ',
      clickable(
        utils.treesitter.location(),
        'plugins.hbar.components.code-location'
      )
    )
  end,
}
