return {
  setup = function()
    vim.api.nvim_create_user_command('LspToolsUpdate', function()
      vim.cmd.MasonUpdate()

      for _, package in ipairs(require('mason-registry').get_all_package_names()) do
        vim.cmd.MasonInstall(package)
      end
    end, { desc = 'lsp: update tools' })

    vim.api.nvim_create_user_command('LspFormat', function()
      vim.cmd([[normal! gg=G]])
      for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
        vim.print({client.id, client.name})
        if vim.bo.modifiable then
          vim.lsp.buf.format({ id = client.id })
        end
      end
      vim.cmd([[normal! zz]])
    end, { desc = 'lsp: format current buffer' })
  end
}
