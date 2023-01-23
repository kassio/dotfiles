local diagnostic = vim.diagnostic
local hl = require('utils.highlights')

-- Default highlight
hl.def('DiagnosticError', { background = 'NONE', foreground = Theme.colors.error })
hl.def('DiagnosticWarn', { background = 'NONE', foreground = Theme.colors.warn })
hl.def('DiagnosticInfo', { background = 'NONE', foreground = Theme.colors.info })
hl.def('DiagnosticHint', { background = 'NONE', foreground = Theme.colors.hint })

-- VirtualText
hl.def('DiagnosticVirtualTextError', { background = 'NONE', foreground = Theme.colors.light_error })
hl.def('DiagnosticVirtualTextWarn', { background = 'NONE', foreground = Theme.colors.light_warn })
hl.def('DiagnosticVirtualTextInfo', { background = 'NONE', foreground = Theme.colors.light_info })
hl.def('DiagnosticVirtualTextHint', { background = 'NONE', foreground = Theme.colors.light_hint })

-- Signs/Icons definition
hl.sign('DiagnosticSignError', Theme.icons.error, 'DiagnosticError')
hl.sign('DiagnosticSignWarn', Theme.icons.warn, 'DiagnosticWarn')
hl.sign('DiagnosticSignInfo', Theme.icons.info, 'DiagnosticInfo')
hl.sign('DiagnosticSignHint', Theme.icons.hint, 'DiagnosticHint')

vim.keymap.set('n', '[d', diagnostic.goto_prev)
vim.keymap.set('n', ']d', diagnostic.goto_next)
vim.keymap.set('n', 'glee', diagnostic.open_float)
vim.keymap.set('n', 'glea', function()
  vim.cmd('silent! cclose')
  diagnostic.setloclist()
end)
vim.keymap.set('n', 'gleA', function()
  vim.cmd('silent! cclose')
  diagnostic.setqflist()
end)

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
