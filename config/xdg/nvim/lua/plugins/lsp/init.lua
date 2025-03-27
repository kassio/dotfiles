return {
  require('plugins.lsp.progress'),
  require('plugins.lsp.installer'),

  {
    'nvimtools/none-ls.nvim',
    dependencies = {
      'nvimtools/none-ls-extras.nvim',
      'gbprod/none-ls-luacheck.nvim',
      'gbprod/none-ls-shellcheck.nvim',
    },
    config = function()
      require('plugins.lsp.handlers').setup()
      require('plugins.lsp.servers').setup()
      require('plugins.lsp.autocmds').setup()
    end,
  },
}
