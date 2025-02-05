return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
  },
  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup({
      automatic_installation = false,
      ensure_installed = {
        'bashls',
        'dockerls',
        'golangci_lint_ls',
        'gopls',
        'jqls',
        'jsonls',
        'jsonnet_ls',
        'rubocop',
        'ruby_lsp',
        'sqlls',
        'sqls',
        'stimulus_ls',
        'tailwindcss',
        'vuels',
      },
    })
  end,
}
