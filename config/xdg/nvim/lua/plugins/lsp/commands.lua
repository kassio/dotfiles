local function command(name, callback, opts)
  opts = opts or {}
  if opts.desc then
    opts.desc = 'lsp: ' .. opts.desc
  end

  vim.api.nvim_create_user_command(name, callback, opts)
end

return {
  setup = function()
    command('LspFormat', function()
      for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
        if vim.bo.modifiable then
          vim.lsp.buf.format({ id = client.id })
        end
      end
    end, { desc = 'format current buffer' })

    command('LspToggleInlayHint', function()
      local has_inlay = vim.tbl_contains(vim.lsp.get_clients({ bufnr = 0 }), function(client)
        return client.server_capabilities.inlayHintProvider
      end)

      if has_inlay then
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
      end
    end, { desc = 'toggle inlay hints' })

    require('plugins.lsp.servers.ruby_lsp.commands').setup(command)
  end,
}
