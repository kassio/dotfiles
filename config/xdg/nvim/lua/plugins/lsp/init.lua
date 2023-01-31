return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'williamboman/mason-lspconfig.nvim',
    'williamboman/mason.nvim',

    -- generic LSP for diagnostic, formatting, etc
    'jose-elias-alvarez/null-ls.nvim',

    -- required for null-ls refactoring module
    {
      'ThePrimeagen/refactoring.nvim',
      dependencies = {
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-treesitter/nvim-treesitter' },
      },
    },
  },
  config = function()
    local lspconfig = require('lspconfig')
    local tools = require('plugins.lsp.tools')
    local attacher = require('plugins.lsp.attacher')
    local capabilities = require('plugins.lsp.capabilities')
    local customizations = require('plugins.lsp.customizations')

    require('plugins.lsp.handlers').setup()
    require('plugins.lsp.generics').setup()
    require('mason').setup()
    require('mason-lspconfig').setup()
    require('mason-tool-installer').setup({
      ensure_installed = tools.packages,
      auto_update = false,
      run_on_start = false,
    })

    local default_opts = {
      single_file_support = true,
      on_attach = attacher,
      capabilities = capabilities,
    }

    for _, server in ipairs(tools.lsps) do
      local settings = customizations[server] or {}

      lspconfig[server].setup(vim.tbl_extend('keep', settings, default_opts))
    end

    -- Auto format files
    vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
      pattern = '*.lua,*.go,*.json,*.js',
      callback = function()
        if not vim.b.skip_format then
          vim.schedule(function()
            vim.lsp.buf.format({ async = false })
          end)
        end
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MasonToolsStartingInstall',
      callback = function()
        vim.schedule(function()
          vim.notify('Starting', vim.log.levels.INFO, { title = 'Updating Mason tools' })
        end)
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MasonToolsUpdateCompleted',
      callback = function()
        vim.schedule(function()
          vim.notify('Finished', vim.log.levels.INFO, { title = 'Updating Mason tools' })
        end)
      end,
    })
  end,
}
