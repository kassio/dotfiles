return {
  require('plugins.lsp.progress'),
  require('plugins.lsp.installer'),

  {
    'nvimtools/none-ls.nvim',
    dependencies = {
      'nvimtools/none-ls-extras.nvim',
      'gbprod/none-ls-luacheck.nvim',
      'gbprod/none-ls-shellcheck.nvim',
    },
    config = function()
      require('plugins.lsp.handlers').setup()
      require('plugins.lsp.servers').setup()
      require('plugins.lsp.autocmds').setup()

      vim.api.nvim_create_user_command('LspToolsUpdate', function()
        vim.cmd.MasonUpdate()

        for _, package in ipairs(require('mason-registry').get_all_package_names()) do
          vim.cmd.MasonInstall(package)
        end
      end, { desc = 'lsp: update tools' })
    end,
  },
}
