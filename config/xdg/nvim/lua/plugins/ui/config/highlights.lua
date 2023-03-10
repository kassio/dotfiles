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
    ['CurSearch'] = { fg = c.base, bg = c.red, italic = true, bold = true },

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

    -- diff
    ['@text.diff.delete'] = { fg = c.error },
    ['@text.diff.change'] = { fg = c.warn },
    ['@text.diff.add'] = { fg = c.hint },

    -- git: diff
    ['GitSignsDelete'] = { link = '@text.diff.delete' },
    ['GitSignsChange'] = { link = '@text.diff.change' },
    ['GitSignsAdd'] = { link = '@text.diff.add' },

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

    -- winbar
    ['WinBar'] = { fg = c.blue, bold = true },
    ['WinBarNC'] = { bg = c.base, fg = c.surface1 },

    -- tabline
    ['TabLine'] = { bg = c.base, fg = c.surface2 },
    ['TabLineSel'] = { bg = c.base, fg = c.blue, bold = true },
    ['TabLineFill'] = { bg = c.surface0, fg = c.surface0 },

    -- hbar: sections
    ['hbar.section.a'] = { bg = c.blue, fg = c.base, bold = true },
    ['hbar.section.b'] = { bg = c.surface0 },
    ['hbar.section.c'] = { bg = c.crust },

    -- hbar: diagnostics
    ['hbar.diagnostics.error'] = { bg = c.surface0, fg = c.error },
    ['hbar.diagnostics.warn'] = { bg = c.surface0, fg = c.warn },
    ['hbar.diagnostics.info'] = { bg = c.surface0, fg = c.info },
    ['hbar.diagnostics.hint'] = { bg = c.surface0, fg = c.hint },

    -- hbar: git
    ['hbar.git.removed'] = { bg = c.surface0, fg = c.error },
    ['hbar.git.changed'] = { bg = c.surface0, fg = c.warn },
    ['hbar.git.added'] = { bg = c.surface0, fg = c.hint },

    -- hbar: mode
    ['hbar.mode.normal'] = { bg = c.blue, fg = c.base, bold = true },
    ['hbar.mode.cmd'] = { bg = c.green, fg = c.base, bold = true },
    ['hbar.mode.insert'] = { bg = c.teal, fg = c.base, bold = true },
    ['hbar.mode.replace'] = { bg = c.pink, fg = c.base, bold = true },
    ['hbar.mode.search'] = { bg = c.pink, fg = c.base, bold = true },
    ['hbar.mode.select'] = { bg = c.pink, fg = c.base, bold = true },
    ['hbar.mode.terminal'] = { bg = c.sapphire, fg = c.base, bold = true },
    ['hbar.mode.visual'] = { bg = c.pink, fg = c.base, bold = true },

    -- dap
    ['DapBreakpoint'] = { fg = c.red },
    ['DapLogPoint'] = { fg = c.blue },
    ['DapStopped'] = { fg = c.green },
    ['DapBreakpointRejected'] = { fg = c.peach },
    ['DapBreakpointCondition'] = { link = 'Number' },
  }
end
