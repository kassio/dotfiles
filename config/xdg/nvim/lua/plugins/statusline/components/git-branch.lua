local theme = require('plugins.highlight.theme')
local hls = require('my.utils.highlights')
local utils = require('plugins.statusline.utils')

hls.extend('Statusline.Git.Branch', 'Theme.Blue.Background', {
  foreground = theme.colors.mantle,
})
hls.extend('Statusline.Git.Branch.Name', 'Statusline.Git.Branch', {
  bold = true,
})

return {
  render = function()
    local branch = vim.g['gitsigns_head']

    if branch == nil then
      return ''
    end

    return string.format(
      '%s  %s%s ',
      utils.highlight('Git', 'Branch'),
      utils.highlight('Git', 'Branch', 'Name'),
      vim.g['gitsigns_head']
    )
  end,
}
