return {
  require('plugins.lsp.progress'),

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- General purpose Language Server
      'nvimtools/none-ls.nvim',
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('plugins.lsp.handlers').setup()
      require('plugins.lsp.servers').setup()
      require('plugins.lsp.autocmds').setup()
    end,
  },
}
