return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function()
      require('catppuccin').setup({
        flavour = 'latte',
        bg = {
          light = 'latte',
          dark = 'frappe',
        },
        color_overrides = {
          all = {
            error = '#CA1243',
            warn = '#F7C154',
            info = '#6699CC',
            hint = '#50A14F',
            error_light = '#FD83A1',
            warn_light = '#FFF4A8',
            info_light = '#A5D0FF',
            hint_light = '#B5E6CE',
          },
        },
        integrations = {
          cmp = true,
          mason = true,
          notify = true,
          nvimtree = true,
          telescope = true,
        },
        show_end_of_buffer = false,
        term_colors = false,
        custom_highlights = function(c)
          return {
            -- search
            ['IncSearch'] = { fg = c.base, bg = c.yellow },
            ['Search'] = { fg = c.base, bg = c.yellow },
            ['CurSearch'] = { fg = c.base, bg = c.blue, italic = true, bold = true },

            -- UI
            ['ColorColumn'] = { bg = c.dim },

            -- treesitter
            ['@method'] = { link = '@function' },
            ['@string'] = { fg = c.green },
            ['@string.specialecial'] = { fg = c.green, bold = true },

            -- msg level
            ['Error'] = { fg = c.error },
            ['Warn'] = { fg = c.warn },
            ['Info'] = { fg = c.info },
            ['Hint'] = { fg = c.hint },

            ['Error.Light'] = { fg = c.error_light },
            ['Warn.Light'] = { fg = c.warn_light },
            ['Info.Light'] = { fg = c.info_light },
            ['Hint.Light'] = { fg = c.hint_light },

            -- Statusline mode highlight
            ['Statusline.Command'] = { fg = c.base, bg = c.hint },
            ['Statusline.Insert'] = { fg = c.base, bg = c.warn },
            ['Statusline.Normal'] = { fg = c.base, bg = c.info },
            ['Statusline.Replace'] = { fg = c.base, bg = c.warn_light },
            ['Statusline.Search'] = { fg = c.base, bg = c.info_light },
            ['Statusline.Terminal'] = { fg = c.base, bg = c.hint },
            ['Statusline.Visual'] = { fg = c.base, bg = c.warn_light },

            -- git: diff
            ['GitSignsDelete'] = { fg = c.error },
            ['GitSignsChange'] = { fg = c.warn },
            ['GitSignsAdd'] = { fg = c.hint },

            -- diagnostics
            ['DiagnosticError'] = { fg = c.error },
            ['DiagnosticWarn'] = { fg = c.warn },
            ['DiagnosticInfo'] = { fg = c.info },
            ['DiagnosticHint'] = { fg = c.hint },

            -- diagnostics: sign
            ['DiagnosticSignError'] = { fg = c.error },
            ['DiagnosticSignWarn'] = { fg = c.warn },
            ['DiagnosticSignInfo'] = { fg = c.info },
            ['DiagnosticSignHint'] = { fg = c.hint },

            -- diagnostics: floating
            ['DiagnosticFloatingError'] = { fg = c.error },
            ['DiagnosticFloatingWarn'] = { fg = c.warn },
            ['DiagnosticFloatingInfo'] = { fg = c.info },
            ['DiagnosticFloatingHint'] = { fg = c.hint },

            -- diagnostics: underline
            ['DiagnosticUnderlineError'] = { special = c.error_light, undercurl = true },
            ['DiagnosticUnderlineWarn'] = { special = c.warn_light, undercurl = true },
            ['DiagnosticUnderlineInfo'] = { special = c.info_light, undercurl = true },
            ['DiagnosticUnderlineHint'] = { special = c.hint_light, undercurl = true },

            -- diagnostics: virtual text
            ['DiagnosticVirtualTextError'] = { fg = c.error_light, italic = true },
            ['DiagnosticVirtualTextWarn'] = { fg = c.warn_light, italic = true },
            ['DiagnosticVirtualTextInfo'] = { fg = c.info_light, italic = true },
            ['DiagnosticVirtualTextHint'] = { fg = c.hint_light, italic = true },

            -- statusline
            ['StatusLine'] = { fg = c.blue },
            ['StatusLineNC'] = { fg = c.surface1 },

            -- winbar
            ['WinBar'] = { bg = c.dim, fg = c.blue },
            ['WinBarNC'] = { bg = c.dim, fg = c.surface1 },
            ['Winbar.Error'] = { bg = c.dim, fg = c.error },
            ['Winbar.Warn'] = { bg = c.dim, fg = c.warn },
            ['Winbar.Info'] = { bg = c.dim, fg = c.info },
            ['Winbar.Hint'] = { bg = c.dim, fg = c.hint },

            -- tabline
            ['TabLine'] = { bg = c.dim, fg = c.surface2 },
            ['TabLineSel'] = { bg = c.dim, fg = c.blue, bold = true },
            ['TabLineFill'] = { bg = c.surface0, fg = c.surface0 },

            -- dap
            ['DapBreakpoint'] = { fg = c.red },
            ['DapLogPoint'] = { fg = c.blue },
            ['DapStopped'] = { fg = c.green },
            ['DapBreakpointRejected'] = { fg = c.peach },
            ['DapBreakpointCondition'] = { link = 'Number' },
          }
        end,
      })

      vim.cmd.colorscheme('catppuccin')
    end,
  },
}
