return {
  { -- Show LSP loading information
    'j-hui/fidget.nvim',
    tag = 'legacy',
    opts = {
      text = { spinner = 'dots' },
    },
  },

  { -- default configuration
    'neovim/nvim-lspconfig',
    config = function()
      local lsp = vim.lsp
      local handlers = lsp.handlers

      handlers['textDocument/hover'] = lsp.with(handlers.hover, { border = 'rounded' })
      handlers['textDocument/signatureHelp'] =
        lsp.with(handlers.signature_help, { border = 'rounded' })

      require('plugins.lsp.servers').setup()
    end,
  },

  { -- formatters and linters
    'nvimdev/guard.nvim',
    -- Builtin configuration, optional
    dependencies = {
      'nvimdev/guard-collection',
    },
    config = function()
      local ft = require('guard.filetype')
      local lint = require('guard.lint')

      ft('go'):fmt('lsp')
      ft('lua'):fmt('stylua'):lint('luacheck'):append('lsp')
      ft('ruby'):lint({
        cmd = 'bundle',
        args = { 'exec', 'rubocop', '--format', 'json', '--force-exclusion', '--stdin' },
        stdin = true,
        parse = function(result, bufnr)
          local decoded = vim.json.decode(result)
          local diagnostics = {}
          local severities = {
            convention = lint.severities.info,
            error = lint.severities.error,
            fatal = lint.severities.fatal,
            info = lint.severities.info,
            refactor = lint.severities.style,
            warning = lint.severities.warning,
          }

          for _, diagnostic in ipairs(decoded.files[1].offenses) do
            table.insert(diagnostics, {
              bufnr = bufnr,
              source = diagnostic.cop_name,
              lnum = diagnostic.location.start_line,
              end_lnum = diagnostic.location.last_line,
              col = diagnostic.location.start_column,
              end_col = diagnostic.location.last_column,
              code = diagnostic.cop_name,
              severity = severities[diagnostic.severity],
              message = diagnostic.message,
            })
          end

          return diagnostics
        end,
      })
      ft('sh'):fmt('shfmt'):lint('shellcheck')

      require('guard').setup({
        fmt_on_save = true,
        lsp_as_default_formatter = false,
      })
    end,
  },
}
