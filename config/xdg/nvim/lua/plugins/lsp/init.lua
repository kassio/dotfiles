return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- generic LSP for diagnostic, formatting, etc
      'jose-elias-alvarez/null-ls.nvim',
    },
    config = function()
      require('plugins.lsp.handlers').setup()
      require('plugins.lsp.attacher').setup()

      require('plugins.lsp.servers').setup()
      require('plugins.lsp.general').setup()
    end,
  },

  -- Show LSP loading information
  {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    config = {
      text = { spinner = 'dots' },
    },
  },
}
