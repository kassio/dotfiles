local utils = require('utils')

return {
  on_click = function(msg, opts)
    utils.to_clipboard(msg, opts.mouse_btn ~= 'l')
  end,
  render = function()
    local location = 'location'

    return {
      formatted = string.format(' %s ', location),
      raw = location,
    }
  end,
}
