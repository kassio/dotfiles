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
    local lsp = vim.lsp
    local handlers = lsp.handlers
    local lspconfig = require('lspconfig')
    local customizations = require('plugins.lsp.customizations')
    local my_servers = require('plugins.lsp.installer')
    local attacher = require('plugins.lsp.attacher')
    local capabilities = require('plugins.lsp.capabilities')

    handlers['textDocument/hover'] = lsp.with(handlers.hover, {
      border = 'rounded',
    })

    handlers['textDocument/signatureHelp'] = lsp.with(handlers.signature_help, {
      border = 'rounded',
    })

    require('plugins.lsp.generics').setup()
    require('mason').setup({
      ui = {
        border = 'none',
        icons = {
          server_installed = Theme.icons.info,
          server_pending = Theme.icons.warn,
          server_uninstalled = Theme.icons.error,
        },
      },
    })
    require('mason-lspconfig').setup()
    require('mason-tool-installer').setup({
      ensure_installed = vim.tbl_keys(my_servers),
      auto_update = false,
      run_on_start = false,
    })

    local default_opts = {
      single_file_support = true,
      on_attach = attacher,
      capabilities = capabilities,
    }

    for _, server in pairs(my_servers) do
      local settings = customizations[server] or {}

      lspconfig[server].setup(vim.tbl_extend('keep', settings, default_opts))
    end

    -- Auto format files
    vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
      pattern = '*.lua,*.go,*.rb,*.json,*.js',
      callback = function()
        lsp.buf.format({ async = false })
      end,
    })
  end,
}
