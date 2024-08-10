return function(c)
  c.bg_sidebar = c.mantle
  c.error = '#CA1243'
  c.warn = '#F7C154'
  c.info = '#6699CC'
  c.hint = '#50A14F'
  c.error_light = '#FD83A1'
  c.warn_light = '#FFF4A8'
  c.info_light = '#A5D0FF'
  c.hint_light = '#B5E6CE'

  local hl = {}
  -- ui
  hl['ColorColumn'] = { bg = c.bg_sidebar }
  hl['WinSeparator'] = { bg = c.bg_sidebar }
  hl['FloatBorder'] = { link = 'NotifyInfoBorder' }

  -- msg level
  hl['Error'] = { fg = c.error }
  hl['Warn'] = { fg = c.warn }
  hl['Info'] = { fg = c.info }
  hl['Hint'] = { fg = c.hint }

  hl['Error.Light'] = { fg = c.error_light }
  hl['Warn.Light'] = { fg = c.warn_light }
  hl['Info.Light'] = { fg = c.info_light }
  hl['Hint.Light'] = { fg = c.hint_light }

  -- diff base
  hl['@diff.removed'] = { fg = c.error }
  hl['@diff.changed'] = { fg = c.warn }
  hl['@diff.added'] = { fg = c.hint }

  -- diagnostics
  hl['DiagnosticError'] = { fg = c.error }
  hl['DiagnosticWarn'] = { fg = c.warn }
  hl['DiagnosticInfo'] = { fg = c.info }
  hl['DiagnosticHint'] = { fg = c.hint }

  -- diagnostics: sign
  hl['DiagnosticSignError'] = { fg = c.error }
  hl['DiagnosticSignWarn'] = { fg = c.warn }
  hl['DiagnosticSignInfo'] = { fg = c.info }
  hl['DiagnosticSignHint'] = { fg = c.hint }

  -- diagnostics: floating
  hl['DiagnosticFloatingError'] = { fg = c.error }
  hl['DiagnosticFloatingWarn'] = { fg = c.warn }
  hl['DiagnosticFloatingInfo'] = { fg = c.info }
  hl['DiagnosticFloatingHint'] = { fg = c.hint }

  -- diagnostics: underline
  hl['DiagnosticUnderlineError'] = { special = c.error_light, undercurl = true }
  hl['DiagnosticUnderlineWarn'] = { special = c.warn_light, undercurl = true }
  hl['DiagnosticUnderlineInfo'] = { special = c.info_light, undercurl = true }
  hl['DiagnosticUnderlineHint'] = { special = c.hint_light, undercurl = true }

  -- diagnostics: virtual text
  hl['DiagnosticVirtualTextError'] = { fg = c.error_light, italic = true }
  hl['DiagnosticVirtualTextWarn'] = { fg = c.warn_light, italic = true }
  hl['DiagnosticVirtualTextInfo'] = { fg = c.info_light, italic = true }
  hl['DiagnosticVirtualTextHint'] = { fg = c.hint_light, italic = true }

  -- statusline
  hl['StatusLine'] = { bg = c.bg_sidebar, fg = c.blue }

  -- statusline: mode highlight
  hl['Statusline.Command'] = { fg = c.bg_sidebar, bg = c.hint }
  hl['Statusline.Insert'] = { fg = c.bg_sidebar, bg = c.warn }
  hl['Statusline.Normal'] = { fg = c.bg_sidebar, bg = c.info }
  hl['Statusline.Replace'] = { fg = c.bg_sidebar, bg = c.warn_light }
  hl['Statusline.Search'] = { fg = c.bg_sidebar, bg = c.info_light }
  hl['Statusline.Terminal'] = { fg = c.bg_sidebar, bg = c.hint }
  hl['Statusline.Visual'] = { fg = c.bg_sidebar, bg = c.warn_light }

  -- winbar
  hl['WinBar'] = { fg = c.blue }
  hl['WinBarNC'] = { fg = c.comment }
  hl['Winbar.Diff.Added'] = { fg = c.hint }
  hl['Winbar.Diff.Changed'] = { fg = c.warn }
  hl['Winbar.Diff.Removed'] = { fg = c.error }
  hl['Winbar.Error'] = { fg = c.error }
  hl['Winbar.Hint'] = { fg = c.hint }
  hl['Winbar.Info'] = { fg = c.info }
  hl['Winbar.Todo'] = { fg = c.info }
  hl['Winbar.Warn'] = { fg = c.warn }

  -- tabline
  hl['TabLine'] = { fg = c.comment }
  hl['TabLineSel'] = { fg = c.blue, bold = true }
  hl['TabLineFill'] = { bg = c.bg_sidebar }

  return hl
end
