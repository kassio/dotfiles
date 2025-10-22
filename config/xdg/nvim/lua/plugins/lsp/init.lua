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
      vim.api.nvim_create_user_command('LspToolsUpdate', function()
        vim.cmd.MasonUpdate()

        for server, _ in pairs(require('plugins.lsp.servers').servers) do
          vim.cmd.MasonInstall(server)
        end
      end, { desc = 'lsp: update tools' })

      require('plugins.lsp.servers').setup()
      require('plugins.lsp.attach').setup()
    end,
  },
}
