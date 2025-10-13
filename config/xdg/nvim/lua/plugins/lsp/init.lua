return {
  require('plugins.lsp.progress'),
  require('plugins.lsp.installer'),

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'creativenull/efmls-configs-nvim',
    },
    config = function()
      require('plugins.lsp.commands').setup()
      require('plugins.lsp.autocmds').setup()
      require('plugins.lsp.handlers').setup()
      require('plugins.lsp.servers').setup()
    end,
  },
}
