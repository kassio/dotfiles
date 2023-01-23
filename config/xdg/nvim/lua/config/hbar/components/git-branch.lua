local utils = require('utils')
local hl = require('config.hbar.utils').highlighter('Statusline', 'Git')

utils.highlights.extend('Statusline.Git.Branch', 'Theme.Blue.Background', {
  foreground = Theme.colors.mantle,
})
utils.highlights.extend('Statusline.Git.Branch.Name', 'Statusline.Git.Branch', {
  bold = true,
})

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
      formatted = string.format('%s  %s%s ', hl('Branch'), hl('Branch', 'Name'), branch),
      raw = branch,
    }
  end,
}
