return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      require('plugins.lsp.progress'),
      require('plugins.lsp.installer'),
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
