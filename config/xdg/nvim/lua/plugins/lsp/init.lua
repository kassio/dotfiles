return {
  require('plugins.lsp.progress'),
  require('plugins.lsp.installer'),

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'nvimtools/none-ls.nvim',
      'nvimtools/none-ls-extras.nvim',
      'gbprod/none-ls-luacheck.nvim',
      'gbprod/none-ls-shellcheck.nvim',
    },
    config = function()
      require('plugins.lsp.commands').setup()
      require('plugins.lsp.autocmds').setup()
      require('plugins.lsp.handlers').setup()
      require('plugins.lsp.servers').setup()
    end,
  },
}
