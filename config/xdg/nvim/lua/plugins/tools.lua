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

    vim.api.nvim_create_user_command('ToolsInstalled', function()
      local packages = vim
        .iter(require('mason-registry').get_installed_packages())
        :fold({}, function(result, package)
          table.insert(result, {
            package_name = package.name,
            lspconfig_name = vim.tbl_get(package.spec, 'neovim', 'lspconfig'),
          })

          return result
        end)

      vim.print(packages)
    end, { desc = 'tools: list installed' })

    vim.api.nvim_create_user_command('ToolsUpdate', function()
      vim.cmd.MasonUpdate()

      for _, server in ipairs(require('plugins.lsp.servers').servers) do
        if server.package_name then
          vim.cmd.MasonInstall(server.package_name)
        end
      end
    end, { desc = 'tools: update tools' })
  end,
}
