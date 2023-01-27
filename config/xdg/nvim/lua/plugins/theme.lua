return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup({
        opts = {
          flavour = 'mocha',
          bg = {
            light = 'latte',
            dark = 'mocha',
          },
          integrations = {
            cmp = true,
            gitsigns = true,
            nvimtree = true,
            telescope = true,
            notify = true,
            mason = true,
          },
        },
        custom_highlights = function(c)
          return {
            -- globals
            ['IncSearch'] = { fg = c.base, bg = c.yellow },
            ['Search'] = { fg = c.base, bg = c.yellow },
            ['CurSearch'] = { fg = c.base, bg = c.red, style = { 'italic', 'bold' } },

            ['@string'] = { fg = c.green },
            ['@string.special'] = { fg = c.green, bold = true },

            -- msg level
            ['Error'] = { fg = c.red },
            ['Warn'] = { fg = c.peach },
            ['Info'] = { fg = c.blue },
            ['Hint'] = { fg = c.green },

            -- diff
            ['@text.diff.delete'] = { fg = c.red },
            ['@text.diff.change'] = { fg = c.yellow },
            ['@text.diff.add'] = { fg = c.green },

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
            ['DiagnosticUnderlineError'] = { link = 'Error' },
            ['DiagnosticUnderlineWarn'] = { link = 'Warn' },
            ['DiagnosticUnderlineInfo'] = { link = 'Info' },
            ['DiagnosticUnderlineHint'] = { link = 'Hint' },

            -- diagnostics: virtual text
            ['DiagnosticVirtualTextError'] = { link = 'Error' },
            ['DiagnosticVirtualTextWarn'] = { link = 'Warn' },
            ['DiagnosticVirtualTextInfo'] = { link = 'Info' },
            ['DiagnosticVirtualTextHint'] = { link = 'Hint' },

            -- winbar
            ['WinBar'] = { fg = c.blue, bold = true },
            ['WinBarNC'] = { bg = c.base, fg = c.surface1 },

            -- hbar: sections
            ['hbar.section.a'] = { bg = c.blue, fg = c.base, bold = true },
            ['hbar.section.b'] = { bg = c.surface0 },
            ['hbar.section.c'] = { bg = c.crust },

            -- hbar: diagnostics
            ['hbar.diagnostics.error'] = { bg = c.surface0, fg = c.red },
            ['hbar.diagnostics.warn'] = { bg = c.surface0, fg = c.peach },
            ['hbar.diagnostics.info'] = { bg = c.surface0, fg = c.info },
            ['hbar.diagnostics.hint'] = { bg = c.surface0, fg = c.green },

            -- hbar: git
            ['hbar.git.removed'] = { bg = c.surface0, fg = c.red },
            ['hbar.git.changed'] = { bg = c.surface0, fg = c.peach },
            ['hbar.git.added'] = { bg = c.surface0, fg = c.info },

            -- hbar: mode
            ['hbar.mode.normal'] = { bg = c.blue, fg = c.base, bold = true },
            ['hbar.mode.cmd'] = { bg = c.green, fg = c.base, bold = true },
            ['hbar.mode.insert'] = { bg = c.teal, fg = c.base, bold = true },
            ['hbar.mode.replace'] = { bg = c.pink, fg = c.base, bold = true },
            ['hbar.mode.search'] = { bg = c.pink, fg = c.base, bold = true },
            ['hbar.mode.select'] = { bg = c.pink, fg = c.base, bold = true },
            ['hbar.mode.terminal'] = { bg = c.sapphire, fg = c.base, bold = true },
            ['hbar.mode.visual'] = { bg = c.pink, fg = c.base, bold = true },

            -- nvim tree
            ['NvimTreeOpenedFile'] = { bold = true, italic = true },
            ['NvimTreeRootFolder'] = { link = 'NvimTreeFolderName', bold = true },

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

  -- Highlight color strings
  {
    'NvChad/nvim-colorizer.lua',
    config = true,
  },

  -- Prettier qf/loc windows
  {
    'https://gitlab.com/yorickpeterse/nvim-pqf.git',
    config = true,
  },
}
