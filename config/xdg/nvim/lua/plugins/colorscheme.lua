return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('tokyonight').setup({
        style = 'storm',
        light_style = 'day',
        terminal_colors = true,
        sidebars = { 'qf', 'help', 'terminal' },
        day_brightness = 0.3,
        on_colors = function(colors)
          if vim.opt.background:get() == 'light' then
            colors.bg = colors.bg_sidebar
            colors.bg_sidebar = require('tokyonight.util').darken(colors.bg, 0.3)
          end

          colors.error = '#CA1243'
          colors.warn = '#F7C154'
          colors.info = '#6699CC'
          colors.hint = '#50A14F'
          colors.error_light = '#FD83A1'
          colors.warn_light = '#FFF4A8'
          colors.info_light = '#A5D0FF'
          colors.hint_light = '#B5E6CE'
        end,
        on_highlights = function(hl, c)
          -- UI
          hl['ColorColumn'] = { bg = c.bg_sidebar }

          -- search
          hl['IncSearch'] = { fg = c.bg, bg = c.warn }
          hl['Search'] = { fg = c.bg, bg = c.warn }
          hl['CurSearch'] = { fg = c.bg, bg = c.blue, italic = true, bold = true }

          -- semantic
          hl['@boolean'] = { fg = c.red }

          -- treesitter
          hl['@method'] = { link = '@function' }
          hl['@string'] = { fg = c.green }
          hl['@string.special'] = { fg = c.green, bold = true }

          -- lsp:ruby
          hl['@lsp.type.namespace.ruby'] = { link = '@constant' }
          hl['@boolean.ruby'] = { link = '@boolean' }
          hl['@string.escape.ruby'] = { link = '@string.special' }

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

          -- git: diff
          hl['GitSignsDelete'] = { fg = c.error }
          hl['GitSignsChange'] = { fg = c.warn }
          hl['GitSignsAdd'] = { fg = c.hint }

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
          hl['StatusLine'] = { bg = c.bg_statusline, fg = c.blue }

          -- Statusline mode highlight
          hl['Statusline.Command'] = { fg = c.bg_statusline, bg = c.hint }
          hl['Statusline.Insert'] = { fg = c.bg_statusline, bg = c.warn }
          hl['Statusline.Normal'] = { fg = c.bg_statusline, bg = c.info }
          hl['Statusline.Replace'] = { fg = c.bg_statusline, bg = c.warn_light }
          hl['Statusline.Search'] = { fg = c.bg_statusline, bg = c.info_light }
          hl['Statusline.Terminal'] = { fg = c.bg_statusline, bg = c.hint }
          hl['Statusline.Visual'] = { fg = c.bg_statusline, bg = c.warn_light }

          -- winbar
          hl['WinBar'] = { bg = c.bg_statusline, fg = c.blue }
          hl['WinBarNC'] = { bg = c.bg_statusline, fg = c.comment }
          hl['Winbar.Diff.Added'] = { bg = c.bg_statusline, fg = c.hint }
          hl['Winbar.Diff.Changed'] = { bg = c.bg_statusline, fg = c.warn }
          hl['Winbar.Diff.Removed'] = { bg = c.bg_statusline, fg = c.error }
          hl['Winbar.Error'] = { bg = c.bg_statusline, fg = c.error }
          hl['Winbar.Hint'] = { bg = c.bg_statusline, fg = c.hint }
          hl['Winbar.Info'] = { bg = c.bg_statusline, fg = c.info }
          hl['Winbar.Todo'] = { bg = c.bg_statusline, fg = c.info }
          hl['Winbar.Warn'] = { bg = c.bg_statusline, fg = c.warn }

          -- tabline
          hl['TabLine'] = { bg = c.bg_statusline, fg = c.comment }
          hl['TabLineSel'] = { bg = c.bg_highlight, fg = c.blue, bold = true }
          hl['TabLineFill'] = { bg = c.bg_statusline }
        end,
      })

      vim.cmd.colorscheme('tokyonight')
    end,
  },
}
