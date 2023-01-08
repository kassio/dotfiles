local hl = require('my.utils.highlights')
local theme = require('plugins.highlight.theme')
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
    R('plugins.git')
    R('plugins.highlight')
    R('plugins.statusline.components.diagnostics')
    R('plugins.statusline.components.git-branch')
    R('plugins.statusline.components.git-status')
    R('plugins.statusline.components.mode')
    R('plugins.statusline.renderer')
    R('plugins.statusline')
    R('plugins.tabline')
    R('plugins.tabline.renderer')
    R('plugins.treesitter')
    R('plugins.winbar')
    R('plugins.winbar.renderer')

    require('plugins.icons').reload_fileicon_extends()
  end
end

command('LightTheme', reloadTheme('light'), {})
command('DarkTheme', reloadTheme('dark'), {})

for name, value in pairs(theme.colors) do
  hl.def(string.format('Theme.%s.Foreground', string.camelcase(name)), { foreground = value })
  hl.def(string.format('Theme.%s.Background', string.camelcase(name)), { background = value })
end

-- globals
hl.def('Search', { background = theme.colors.warn, foreground = theme.colors.base })
hl.def('CurSearch', { background = theme.colors.info, foreground = theme.colors.base })
hl.def('IncSearch', { background = theme.colors.warn, foreground = theme.colors.base })
hl.def('VertSplit', { foreground = theme.colors.blue })
hl.def('ColorColumn', { background = theme.colors.mantle })

-- Spell
hl.def('SpellBad', { undercurl = true, special = theme.colors.warn })
hl.extend('SpellCap', 'SpellBad')
hl.extend('SpellRare', 'SpellBad')
hl.extend('SpellLocal', 'SpellBad')

-- matching parantheses/blocks marks
hl.def('MatchParen', { bold = true })

-- zsh
hl.extend('zshQuoted', 'String', { bold = true })
