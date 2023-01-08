local theme = require('plugins.highlight.theme')
local utils = require('my.utils')
local hl = require('plugins.hbar.utils').highlighter('Statusline', 'Git')

utils.highlights.extend('Statusline.Git.Branch', 'Theme.Blue.Background', {
  foreground = theme.colors.mantle,
})
utils.highlights.extend('Statusline.Git.Branch.Name', 'Statusline.Git.Branch', {
  bold = true,
})

return {
  render = function()
    local branch = vim.g['gitsigns_head']

    if branch == nil then
      return ''
    end

    return string.format('%s  %s%s ', hl('Branch'), hl('Branch', 'Name'), vim.g['gitsigns_head'])
  end,
}
