return {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      require('rose-pine').setup({
        groups = {
          error = 'love',
          hint = 'iris',
          info = 'foam',
          warn = 'gold',
          dim = 'muted',
        },
        highlight_groups = {
          Error = { fg = 'error' },
          Hint = { fg = 'hint' },
          Info = { fg = 'info' },
          Warn = { fg = 'warn' },

          ['Statusline.Command'] = { fg = 'base', bg = 'hint' },
          ['Statusline.Insert'] = { fg = 'base', bg = 'warn' },
          ['Statusline.Normal'] = { fg = 'base', bg = 'info' },
          ['Statusline.Replace'] = { fg = 'base', bg = 'warn_light' },
          ['Statusline.Search'] = { fg = 'base', bg = 'info_light' },
          ['Statusline.Terminal'] = { fg = 'base', bg = 'hint' },
          ['Statusline.Visual'] = { fg = 'base', bg = 'warn_light' },

          -- git: diff
          ['GitSignsDelete'] = { fg = 'error' },
          ['GitSignsChange'] = { fg = 'warn' },
          ['GitSignsAdd'] = { fg = 'hint' },

          -- diagnostics
          ['DiagnosticError'] = { fg = 'error' },
          ['DiagnosticWarn'] = { fg = 'warn' },
          ['DiagnosticInfo'] = { fg = 'info' },
          ['DiagnosticHint'] = { fg = 'hint' },

          -- diagnostics: sign
          ['DiagnosticSignError'] = { fg = 'error' },
          ['DiagnosticSignWarn'] = { fg = 'warn' },
          ['DiagnosticSignInfo'] = { fg = 'info' },
          ['DiagnosticSignHint'] = { fg = 'hint' },

          -- diagnostics: floating
          ['DiagnosticFloatingError'] = { fg = 'error' },
          ['DiagnosticFloatingWarn'] = { fg = 'warn' },
          ['DiagnosticFloatingInfo'] = { fg = 'info' },
          ['DiagnosticFloatingHint'] = { fg = 'hint' },

          -- diagnostics: underline
          ['DiagnosticUnderlineError'] = { special = 'error_light', undercurl = true },
          ['DiagnosticUnderlineWarn'] = { special = 'warn_light', undercurl = true },
          ['DiagnosticUnderlineInfo'] = { special = 'info_light', undercurl = true },
          ['DiagnosticUnderlineHint'] = { special = 'hint_light', undercurl = true },

          -- diagnostics: virtual text
          ['DiagnosticVirtualTextError'] = { fg = 'error_light', italic = true },
          ['DiagnosticVirtualTextWarn'] = { fg = 'warn_light', italic = true },
          ['DiagnosticVirtualTextInfo'] = { fg = 'info_light', italic = true },
          ['DiagnosticVirtualTextHint'] = { fg = 'hint_light', italic = true },

          -- statusline
          ['StatusLine'] = { fg = 'info' },
          ['StatusLineNC'] = { fg = 'surface1' },

          -- winbar
          ['WinBar'] = { bg = 'dim', fg = 'info' },
          ['WinBarNC'] = { bg = 'dim', fg = 'surface1' },
          ['Winbar.Error'] = { bg = 'dim', fg = 'error' },
          ['Winbar.Warn'] = { bg = 'dim', fg = 'warn' },
          ['Winbar.Info'] = { bg = 'dim', fg = 'info' },
          ['Winbar.Hint'] = { bg = 'dim', fg = 'hint' },

          -- tabline
          ['TabLine'] = { bg = 'dim', fg = 'surface2' },
          ['TabLineSel'] = { bg = 'surface0', fg = 'info', bold = true },
          ['TabLineFill'] = { bg = 'dim', fg = 'surface0' },

          -- dap
          ['DapBreakpoint'] = { fg = 'error' },
          ['DapLogPoint'] = { fg = 'info' },
          ['DapStopped'] = { fg = 'hint' },
          ['DapBreakpointRejected'] = { fg = 'peach' },
          ['DapBreakpointCondition'] = { link = 'Number' },
        },
      })

      vim.cmd.colorscheme('rose-pine')
    end,
  },
}
