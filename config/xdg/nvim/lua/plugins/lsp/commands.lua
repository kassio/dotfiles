return {
  setup = function()
    vim.api.nvim_create_user_command('LspToolsUpdate', function()
      vim.cmd.MasonUpdate()

      for _, package in ipairs(require('mason-registry').get_installed_packages()) do
        vim.cmd.MasonInstall(package.name)
      end
    end, { desc = 'lsp: update tools' })

    vim.api.nvim_create_user_command('LspFormat', function()
      require('utils.buffers').preserve(function()
        vim.cmd([[normal! gg=G]])
        for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
          vim.print({ client.id, client.name })
          if vim.bo.modifiable then
            vim.lsp.buf.format({ id = client.id })
          end
        end
      end)
    end, { desc = 'lsp: format current buffer' })
  end,
}
