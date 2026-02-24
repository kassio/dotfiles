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

    vim.api.nvim_create_user_command('ToolsInstalled', function(opts)
      local packages = vim
        .iter(require('mason-registry').get_installed_packages())
        :fold({}, function(result, package)
          table.insert(result, {
            package_name = package.name,
            lspconfig_name = vim.tbl_get(package.spec, 'neovim', 'lspconfig'),
          })

          return result
        end)
      -- :totable()

      if opts.bang then
        local packages_file =
          vim.fs.joinpath(vim.fn.stdpath('config'), 'lua/plugins/tools/packages.lua')

        -- Sort by lspconfig_name
        table.sort(packages, function(pck1, pck2)
          return pck1.lspconfig_name < pck2.lspconfig_name
        end)

        -- Stringify each config
        local list = vim.iter(packages):fold({}, function(result, package)
          table.insert(result, vim.inspect(package, { newline = '', indent = '' }) .. ',')
          return result
        end)

        -- Write to the file
        vim.fn.writefile(
          vim.fn.flatten({
            'return {',
            '-- Manual installation',
            [[{ lspconfig_name = 'gitlab_duo' },]],
            [[{ lspconfig_name = 'gitlab_lsp' },]],
            '-- From ToolsInstalled',
            list,
            '}',
          }),
          packages_file
        )

        -- Open the file (for formatting or manual editing)
        vim.cmd('tabedit ' .. vim.fn.fnameescape(packages_file))
      else
        vim.print(packages)
      end
    end, {
      desc = 'tools: list installed',
      bang = true,
    })

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
