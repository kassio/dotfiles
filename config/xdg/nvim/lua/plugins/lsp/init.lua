return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lsp = vim.lsp
      local handlers = lsp.handlers

      handlers['textDocument/hover'] = lsp.with(handlers.hover, {
        border = 'rounded',
      })

      handlers['textDocument/signatureHelp'] = lsp.with(handlers.signature_help, {
        border = 'rounded',
      })

      require('plugins.lsp.servers').setup()
    end,
  },

  -- Show LSP loading information
  {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    opts = {
      text = { spinner = 'dots' },
    },
  },
}
