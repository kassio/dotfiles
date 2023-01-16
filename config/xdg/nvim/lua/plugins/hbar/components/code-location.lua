local utils = require('my.utils')

return {
  on_click = function(msg, opts)
    utils.to_clipboard(msg, opts.mouse_btn ~= 'l')
  end,
  render = function()
    local location = utils.treesitter.location()

    return {
      formatted = string.format(' %s ', location),
      raw = location,
    }
  end,
}
