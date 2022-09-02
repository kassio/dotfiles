local theme = require('plugins.highlight.theme')
local hl = require('my.utils.highlights')
local colors = theme.colors

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

-- globals
hl.def('Search', { background = colors.warn, foreground = colors.shadow })
hl.def('CurSearch', { background = colors.info, foreground = colors.shadow })
hl.def('IncSearch', { background = colors.warn, foreground = colors.shadow })

-- Spell
hl.def('SpellBad', { underdotted = true, sp = colors.warn })
hl.extend('SpellCap', 'SpellBad')
hl.extend('SpellRare', 'SpellBad')
hl.extend('SpellLocal', 'SpellBad')

-- Floating wind:ow
hl.def('NormalFloat', { background = colors.background })

-- matching parantheses/blocks marks
hl.def('MatchParen', { bold = true })

-- zsh
hl.extend('zshQuoted', 'String', { bold = true })
