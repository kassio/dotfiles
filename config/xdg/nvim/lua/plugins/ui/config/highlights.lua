return function(colors)
  local c = vim.tbl_extend('keep', {
    error = '#CA1243',
    warn = '#F7C154',
    info = '#6699CC',
    hint = '#50A14F',
    error_light = '#FD83A1',
    warn_light = '#FFF4A8',
    info_light = '#A5D0FF',
    hint_light = '#B5E6CE',
  }, colors)

  return {
    -- globals
    ['IncSearch'] = { fg = c.base, bg = c.yellow },
    ['Search'] = { fg = c.base, bg = c.yellow },
    ['CurSearch'] = { fg = c.base, bg = c.blue, italic = true, bold = true },

    ['@string'] = { fg = c.green },
    ['@string.special'] = { fg = c.green, bold = true },

    -- msg level
    ['Error'] = { fg = c.error },
    ['Warn'] = { fg = c.warn },
    ['Info'] = { fg = c.info },
    ['Hint'] = { fg = c.hint },

    ['Error.Light'] = { fg = c.error_light },
    ['Warn.Light'] = { fg = c.warn_light },
    ['Info.Light'] = { fg = c.info_light },
    ['Hint.Light'] = { fg = c.hint_light },

    -- git: diff
    ['GitSignsDelete'] = { link = 'Error' },
    ['GitSignsChange'] = { link = 'Warn' },
    ['GitSignsAdd'] = { link = 'Hint' },

    -- diagnostics
    ['DiagnosticError'] = { link = 'Error' },
    ['DiagnosticWarn'] = { link = 'Warn' },
    ['DiagnosticInfo'] = { link = 'Info' },
    ['DiagnosticHint'] = { link = 'Hint' },

    -- diagnostics: sign
    ['DiagnosticSignError'] = { link = 'Error' },
    ['DiagnosticSignWarn'] = { link = 'Warn' },
    ['DiagnosticSignInfo'] = { link = 'Info' },
    ['DiagnosticSignHint'] = { link = 'Hint' },

    -- diagnostics: floating
    ['DiagnosticFloatingError'] = { link = 'Error' },
    ['DiagnosticFloatingWarn'] = { link = 'Warn' },
    ['DiagnosticFloatingInfo'] = { link = 'Info' },
    ['DiagnosticFloatingHint'] = { link = 'Hint' },

    -- diagnostics: underline
    ['DiagnosticUnderlineError'] = { link = 'Error.Light' },
    ['DiagnosticUnderlineWarn'] = { link = 'Warn.Light' },
    ['DiagnosticUnderlineInfo'] = { link = 'Info.Light' },
    ['DiagnosticUnderlineHint'] = { link = 'Hint.Light' },

    -- diagnostics: virtual text
    ['DiagnosticVirtualTextError'] = { link = 'Error.Light' },
    ['DiagnosticVirtualTextWarn'] = { link = 'Warn.Light' },
    ['DiagnosticVirtualTextInfo'] = { link = 'Info.Light' },
    ['DiagnosticVirtualTextHint'] = { link = 'Hint.Light' },

    -- statusline
    ['StatusLine'] = { fg = c.blue },
    ['StatusLineNC'] = { fg = c.surface1 },

    -- winbar
    ['WinBar'] = { fg = c.blue, bold = true },
    ['WinBarNC'] = { bg = c.base, fg = c.surface1 },

    -- tabline
    ['TabLine'] = { bg = c.base, fg = c.surface2 },
    ['TabLineSel'] = { bg = c.base, fg = c.blue, bold = true },
    ['TabLineFill'] = { bg = c.surface0, fg = c.surface0 },

    -- dap
    ['DapBreakpoint'] = { fg = c.red },
    ['DapLogPoint'] = { fg = c.blue },
    ['DapStopped'] = { fg = c.green },
    ['DapBreakpointRejected'] = { fg = c.peach },
    ['DapBreakpointCondition'] = { link = 'Number' },
  }
end
