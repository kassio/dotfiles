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

      ft('go'):fmt('lsp')
      ft('lua'):fmt('stylua'):lint('luacheck'):append('lsp')
      ft('ruby'):lint('rubocop')
      ft('sh'):fmt('shfmt'):lint('shellcheck')

      require('guard').setup({
        fmt_on_save = true,
        lsp_as_default_formatter = false,
      })
    end,
  },
}
