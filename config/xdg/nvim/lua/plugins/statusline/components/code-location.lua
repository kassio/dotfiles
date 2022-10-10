local utils = require('my.utils')

return {
  render = function()
    return string.format(' %s ', utils.treesitter.location())
  end,
}
