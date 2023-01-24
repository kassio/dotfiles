return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'williamboman/mason-lspconfig.nvim',
    'williamboman/mason.nvim',

    -- generic LSP for diagnostic, formatting, etc
    'jose-elias-alvarez/null-ls.nvim',

    -- required for null-ls refactoring module
    'ThePrimeagen/refactoring.nvim',
  },
  config = function()
    require('plugins.lsp.handlers').setup()
    require('plugins.lsp.installer').setup()
    require('plugins.lsp.generics').setup()

    -- Auto format files
    vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
      pattern = '*.lua,*.go,*.rb,*.json,*.js',
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end,
}
