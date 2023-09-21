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

      local function lsp_format(bufnr)
        if not vim.bo[bufnr].modifiable or vim.b[bufnr].skip_autoformat == true then
          return
        end

        local efm = vim.lsp.get_clients({ name = 'efm' })

        if vim.tbl_isempty(efm) then
          vim.lsp.buf.format()
        else
          vim.lsp.buf.format({ name = 'efm' })
        end
      end

      vim.api.nvim_create_user_command('LspFormat', function()
        lsp_format(vim.api.nvim_get_current_buf())
      end, {})

      vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
        group = vim.api.nvim_create_augroup('user:lsp', { clear = false }),
        callback = function(args)
          lsp_format(args.buf)
        end,
      })
    end,
  },
}
