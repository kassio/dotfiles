return {
  require('plugins.lsp.progress'),

  {
    'neovim/nvim-lspconfig',
    config = function()
      require('plugins.lsp.handlers').setup()
      require('plugins.lsp.servers').setup()
      require('plugins.lsp.autocmds').setup()
    end,
  },
}
