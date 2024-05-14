return {
  require('plugins.lsp.progress'),

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'nvimtools/none-ls.nvim',
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
