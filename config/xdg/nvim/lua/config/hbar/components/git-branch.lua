local utils = require('utils')

return {
  on_click = function(msg, opts)
    utils.to_clipboard(msg, opts.mouse_btn ~= 'l')
  end,
  render = function()
    local branch = vim.g['gitsigns_head']

    if branch == nil then
      return ''
    end

    return {
      formatted = string.format('  %s ', branch),
      raw = branch,
    }
  end,
}
