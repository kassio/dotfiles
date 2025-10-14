return {
  setup = function()
    vim.api.nvim_create_user_command('LspToolsUpdate', function()
      vim.cmd.MasonUpdate()

      for server, _ in pairs(require('plugins.lsp.servers').servers) do
        vim.cmd.MasonInstall(server)
      end
    end, { desc = 'lsp: update tools' })

    vim.api.nvim_create_user_command('LspFormat', function()
      require('utils.buffers').preserve(function()
        vim.cmd([[normal! gg=G]])
        for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
          if vim.bo.modifiable then
            vim.lsp.buf.format({ id = client.id })
          end
        end
      end)
    end, { desc = 'lsp: format current buffer' })
  end,
}
