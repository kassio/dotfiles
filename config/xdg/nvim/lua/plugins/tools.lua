return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
  },
  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup({
      automatic_installation = false,
      ensure_installed = require('utils.table').keys_except(
        require('plugins.lsp.servers').servers,
        'gitlab_lsp',
        'gitlab_duo'
      )
    })
  end,
}
