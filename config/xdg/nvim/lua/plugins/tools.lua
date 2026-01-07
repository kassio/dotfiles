return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
  },
  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup({
      automatic_installation = false,
      ensure_installed = require('plugins.lsp.servers').installable,
    })

    vim.api.nvim_create_user_command('ToolsUpdate', function()
      vim.cmd.MasonUpdate()

      for server, _ in pairs(require('plugins.lsp.servers').servers) do
        vim.cmd.MasonInstall(server)
      end
    end, { desc = 'lsp: update tools' })
  end,
}
