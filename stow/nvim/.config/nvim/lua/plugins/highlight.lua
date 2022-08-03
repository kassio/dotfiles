local theme = vim.my.theme
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

local sign_define = function(name, sign, highlight)
  vim.fn.sign_define(name, { text = sign, texthl = highlight or name })
end

local hl = function(name, extra)
  extra = extra or {}

  local ok, data = pcall(vim.api.nvim_get_hl_by_name, name, true)
  if not ok then
    return false, string.format('Failed to find highlight by name "%s"', name)
  end

  return true, vim.tbl_extend('force', data, extra)
end

local hl_def = function(group, color)
  local ok, msg = pcall(vim.api.nvim_set_hl, 0, group, color)

  if not ok then
    P(
      string.format(
        'Failed to set highlight (%s): group %s | color: %s',
        msg,
        group,
        vim.inspect(color)
      )
    )
  end
end

local hl_extend = function(target, source, opts)
  local ok, source_hl = hl(source, opts or {})

  if ok then
    hl_def(target, source_hl)
  else
    P(string.format('Failed to extend %s with %s: %s', target, source, vim.inspect(source_hl)))
    hl_def(target, opts or {})
  end
end

-- globals
hl_def('Search', { background = colors.warn, foreground = colors.shadow })
hl_def('CurSearch', { background = colors.info, foreground = colors.shadow })
hl_def('IncSearch', { background = colors.warn, foreground = colors.shadow })

-- Diagnostics (vim.diagnostic)
-- Default highlight
hl_def('DiagnosticError', { background = 'NONE', foreground = colors.error })
hl_def('DiagnosticWarn', { background = 'NONE', foreground = colors.warn })
hl_def('DiagnosticInfo', { background = 'NONE', foreground = colors.info })
hl_def('DiagnosticHint', { background = 'NONE', foreground = colors.hint })

-- VirtualText
hl_def('DiagnosticVirtualTextError', { background = 'NONE', foreground = colors.light_error })
hl_def('DiagnosticVirtualTextWarn', { background = 'NONE', foreground = colors.light_warn })
hl_def('DiagnosticVirtualTextInfo', { background = 'NONE', foreground = colors.light_info })
hl_def('DiagnosticVirtualTextHint', { background = 'NONE', foreground = colors.light_hint })

-- Signs/Icons definition
sign_define('DiagnosticSignError', theme.icons.error, 'DiagnosticError')
sign_define('DiagnosticSignWarn', theme.icons.warn, 'DiagnosticWarn')
sign_define('DiagnosticSignInfo', theme.icons.info, 'DiagnosticInfo')
sign_define('DiagnosticSignHint', theme.icons.hint, 'DiagnosticHint')

-- Debugger
sign_define('DapBreakpoint', '●')
hl_def('DapBreakpoint', { foreground = colors.error })

sign_define('DapBreakpointCondition', '◆')
hl_extend('DapBreakpointCondition', 'Number')

sign_define('DapLogPoint', 'Ξ')
hl_def('DapLogPoint', { foreground = colors.info })

sign_define('DapStopped', '▶')
hl_def('DapStopped', { foreground = colors.hint })

sign_define('DapBreakpointRejected', '◎')
hl_def('DapBreakpointRejected', { foreground = colors.warn })

-- Git
hl_def('GitSignsCurrentLineBlame', {
  background = colors.shadow,
  foreground = colors.highlight,
  italic = true,
})

hl_def('GitSignAdd', { foreground = colors.hint })
hl_def('GitSignChange', { foreground = colors.warn })
hl_def('GitSignDelete', { foreground = colors.error })

hl_def('GitSignAddLineNr', { foreground = colors.hint })
hl_def('GitSignChangeLineNr', { foreground = colors.warn })
hl_def('GitSignDeleteLineNr', { foreground = colors.error })

-- Spell
hl_def('SpellBad', { underdotted = true, sp = colors.warn })
hl_extend('SpellCap', 'SpellBad')
hl_extend('SpellRare', 'SpellBad')
hl_extend('SpellLocal', 'SpellBad')

-- Floating window
hl_def('NormalFloat', { background = colors.background })

-- matching parantheses/blocks marks
hl_def('MatchParen', { bold = true })

-- Filetree
hl_def('NvimTreeOpenedFile', { bold = true, italic = false })

-- Treesitter globals
hl_extend('TSTypeBuiltin', 'Type')
hl_extend('TSVariable', 'Normal')
hl_extend('TSParameter', 'Normal')
hl_extend('TSFuncBuiltin', 'Identifier')
hl_extend('TSStringEscape', 'String', { bold = true })
hl_extend('TSStringSpecial', 'String', { bold = true })

-- refactoring
hl_def('TSDefinitionUsage', { background = colors.light_warn, foreground = colors.shadow })
hl_def('TSDefinition', { background = colors.light_warn })

-- Ruby with Treesitter
hl_extend('rubyTSType', 'Type')
hl_extend('rubyTSLabel', 'Identifier')
hl_extend('rubyTSSymbol', 'Identifier')
hl_extend('rubyTSVariableBuiltin', 'Constant')

-- Go with Treesitter
hl_extend('goTSnamespace', 'Normal', { bold = true })
hl_extend('goTSvariable', 'Normal')
hl_extend('goTSfunction_name', 'Function')
hl_extend('goTSproperty', 'Function')

-- zsh
hl_extend('zshQuoted', 'String', { bold = true })

-- tabline
-- TabLineSel and TabLineFill.  |hl-TabLine| |hl-TabLineSel| |hl-TabLineFill|
hl_def('TabLine', {
  background = colors.background,
  foreground = colors.highlight,
})
hl_extend('TabLineFill', 'TabLine')
hl_extend('TabLineSel', 'TabLine', {
  background = colors.info,
  foreground = colors.shadow,
  bold = true,
})

-- winbar
hl_def('WinBar', {
  background = colors.background,
  foreground = colors.highlight,
  underdouble = true,
  sp = colors.shadow,
})
hl_extend('WinBarNC', 'WinBar', { foreground = colors.shadow })
hl_extend('WinBarInfo', 'WinBar', { foreground = colors.info, bold = true })
hl_extend('WinBarWarn', 'WinBar', { foreground = colors.warn, bold = true })

-- Filetree
hl_def('NvimTreeRootFolder', { foreground = colors.highlight })
