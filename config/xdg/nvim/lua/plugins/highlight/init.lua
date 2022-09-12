local hl = require('my.utils.highlights')
local theme = require('plugins.highlight.theme')
local colors = theme.colors
local command = vim.api.nvim_create_user_command

-- Highlight color strings
require('colorizer').setup()
-- Prettier quickfix/location list windows
require('pqf').setup({
  signs = {
    error = theme.icons.error,
    warning = theme.icons.warn,
    info = theme.icons.info,
    hint = theme.icons.hint,
  },
})

local reloadTheme = function(bg)
  return function()
    theme.set(bg)

    R('plugins.filetree')
    R('plugins.statusline')
    R('plugins.tabline.utils')
    R('plugins.tabline')
    R('plugins.winbar.utils')
    R('plugins.winbar')
    R('plugins.git')
  end
end

command('LightTheme', reloadTheme('light'), {})
command('DarkTheme', reloadTheme('dark'), {})

-- globals
hl.def('Search', { background = colors.warn, foreground = theme['Normal'].background })
hl.def('CurSearch', { background = colors.info, foreground = theme['Normal'].background })
hl.def('IncSearch', { background = colors.warn, foreground = theme['Normal'].background })
hl.def('VertSplit', { foreground = colors.blue })

-- Spell
hl.def('SpellBad', { undercurl = true, special = colors.warn })
hl.extend('SpellCap', 'SpellBad')
hl.extend('SpellRare', 'SpellBad')
hl.extend('SpellLocal', 'SpellBad')

-- Floating wind:ow
hl.def('NormalFloat', { background = theme['Normal'].background })

-- matching parantheses/blocks marks
hl.def('MatchParen', { bold = true })

-- zsh
hl.extend('zshQuoted', 'String', { bold = true })
