local theme = require('plugins.highlight.theme')
local hl = require('my.utils.highlights')
local colors = theme.colors
local keymap = vim.keymap.set
local diagnostic = vim.diagnostic

-- Default highlight
hl.def('DiagnosticError', { background = 'NONE', foreground = colors.error })
hl.def('DiagnosticWarn', { background = 'NONE', foreground = colors.warn })
hl.def('DiagnosticInfo', { background = 'NONE', foreground = colors.info })
hl.def('DiagnosticHint', { background = 'NONE', foreground = colors.hint })

-- VirtualText
hl.def('DiagnosticVirtualTextError', { background = 'NONE', foreground = colors.light_error })
hl.def('DiagnosticVirtualTextWarn', { background = 'NONE', foreground = colors.light_warn })
hl.def('DiagnosticVirtualTextInfo', { background = 'NONE', foreground = colors.light_info })
hl.def('DiagnosticVirtualTextHint', { background = 'NONE', foreground = colors.light_hint })

-- Signs/Icons definition
hl.sign('DiagnosticSignError', theme.icons.error, 'DiagnosticError')
hl.sign('DiagnosticSignWarn', theme.icons.warn, 'DiagnosticWarn')
hl.sign('DiagnosticSignInfo', theme.icons.info, 'DiagnosticInfo')
hl.sign('DiagnosticSignHint', theme.icons.hint, 'DiagnosticHint')

diagnostic.config({
  virtual_text = {
    severity = diagnostic.severity.ERROR,
    spacing = 8,
  },
  underline = false,
  severity_sort = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})

keymap('n', '[d', diagnostic.goto_prev)
keymap('n', ']d', diagnostic.goto_next)
keymap('n', 'glee', diagnostic.open_float)
keymap('n', 'glea', function()
  vim.cmd('silent! cclose')
  diagnostic.setloclist()
end)
keymap('n', 'gleA', function()
  vim.cmd('silent! cclose')
  diagnostic.setqflist()
end)
