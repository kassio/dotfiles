local function command(name, cb, opts)
  local desc = opts.desc
  opts.desc = 'lsp: ' .. desc

  vim.api.nvim_create_user_command(name, function()
    cb(opts)
  end, opts)
end

return {
  setup = function()
    require('plugins.lsp.servers.ruby_lsp.commands').setup(command)

    command('LspFormat', function()
      vim.lsp.buf.format({ async = false })
    end, { desc = 'format current buffer' })

    command('LspToggleInlayHint', function()
      local has_inlay = vim.tbl_contains(vim.lsp.get_clients({ bufnr = 0 }), function(client)
        return client.server_capabilities.inlayHintProvider
      end)

      if has_inlay then
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
      end
    end, { desc = 'toggle inlay hints' })
  end,
}
