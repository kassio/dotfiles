return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'j-hui/fidget.nvim',
        tag = 'legacy',
        opts = {
          text = {
            spinner = 'dots',
          },
          sources = {
            ['null-ls'] = {
              ignore = true,
            },
          },
        },
      },
    },
    config = function()
      require('plugins.lsp.servers').setup()
      require('plugins.lsp.attach').setup()
    end,
  },
}
