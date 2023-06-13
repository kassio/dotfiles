return {
  {
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
      local tools = require('plugins.lsp.tools')

      require('plugins.lsp.handlers').setup()
      require('plugins.lsp.generics').setup()
      require('mason').setup()
      require('mason-lspconfig').setup()
      require('mason-tool-installer').setup({
        ensure_installed = tools.packages,
        auto_update = false,
        run_on_start = false,
      })

      tools.setup({
        single_file_support = true,
        on_attach = require('plugins.lsp.attacher'),
        capabilities = require('plugins.lsp.capabilities'),
      })

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
  },

  -- Show LSP loading information
  {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    config = {
      text = { spinner = 'dots' },
    },
  },
}
