local theme = require('plugins.highlight.theme')
local hls = require('my.utils.highlights')
local utils = require('plugins.statusline.utils')

hls.def('StatuslineGitBranch', {
  background = theme.colors.blue,
  foreground = theme.colors.mantle,
  bold = true,
})

return {
  render = function()
    local branch = vim.g['gitsigns_head']

    if branch == nil then
      return ''
    end

    return string.format(
      '%s  %s ',
      utils.highlight('StatuslineGitBranch'),
      vim.g['gitsigns_head']
    )
  end,
}
