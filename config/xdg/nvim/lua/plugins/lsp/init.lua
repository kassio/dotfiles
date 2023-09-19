return {
  { -- Show LSP loading information
    'j-hui/fidget.nvim',
    tag = 'legacy',
    opts = {
      text = { spinner = 'dots' },
    },
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- General purpose Language Server
      'creativenull/efmls-configs-nvim',
    },
    config = function()
      require('plugins.lsp.handlers').setup()
      require('plugins.lsp.servers').setup()

      vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
        group = vim.api.nvim_create_augroup('user:lsp', { clear = false }),
        callback = function(args)
          if not vim.bo[args.buf].modifiable or vim.b[args.buf].skip_autoformat == true then
            return
          end

          local efm = vim.lsp.get_clients({ name = 'efm' })

          if vim.tbl_isempty(efm) then
            vim.lsp.buf.format()
          else
            vim.lsp.buf.format({ name = 'efm' })
          end
        end,
      })
    end,
  },
}
