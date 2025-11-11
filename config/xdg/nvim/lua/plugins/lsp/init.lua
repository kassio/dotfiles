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

      local lsp_utils = require('plugins.lsp.utils')

      vim.api.nvim_create_autocmd({ 'LspAttach' }, {
        callback = function(opts)
          require('plugins.lsp.keymaps').setup(opts.buf)
        end
      })

      vim.api.nvim_create_user_command('LspFormat', function()
        lsp_utils.format()
      end, { desc = 'lsp: format current buffer'})

      vim.api.nvim_create_autocmd('BufWritePre', {
        callback = function(opts)
          if vim.b[opts.buf].autoformat ~= false then
            lsp_utils.format()
          end
        end,
      })
    end,
  },
}
