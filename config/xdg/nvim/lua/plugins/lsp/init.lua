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
      'creativenull/efmls-configs-nvim',
    },
    config = function()
      local lsp = vim.lsp
      local handlers = lsp.handlers
      local lspconfig = require('lspconfig')
      local capabilities = require('plugins.lsp.capabilities')
      local servers = require('plugins.lsp.servers')

      lsp.set_log_level(lsp.log_levels.WARN)

      handlers['textDocument/hover'] = lsp.with(handlers.hover, {
        border = 'rounded',
      })
      handlers['textDocument/signatureHelp'] = lsp.with(handlers.signature_help, {
        border = 'rounded',
      })

      for server, opts in pairs(servers) do
        local config = vim.tbl_deep_extend('force', opts or {}, {
          single_file_support = true,
          capabilities = capabilities,
        })

        if server == 'efm' then
          vim.fn.writefile( vim.split(vim.inspect(config), '\n') , vim.lsp.get_log_path())
        end

        lspconfig[server].setup(config)
      end
    end,
  },
}
