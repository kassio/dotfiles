local utils = require('utils')

local function command(name, cb, opts)
  local desc = opts.desc
  opts.desc = 'lsp: ' .. desc

  vim.api.nvim_create_user_command(name, function()
    cb(opts)
  end, opts)
end

return {
  setup = function()
    require('plugins.lsp.servers.ruby_ls.commands').setup(command)

    command('LspFormat', function()
      local filetype = vim.bo.filetype
      local can_format = vim.bo.modifiable
        and filetype ~= ''
        and not utils.plugin_filetype(filetype)
        and vim.b.skip_autoformat ~= true

      if not can_format then
        return
      end

      for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
        vim.lsp.buf.format({ name = client.name, async = false })
      end
    end, { desc = 'format document' })

    command('LspToggleInlayHint', function()
      local has_inlay = vim.tbl_contains(vim.lsp.get_clients({ bufnr = 0 }), function(client)
        return client.server_capabilities.inlayHintProvider
      end)

      if has_inlay then
        vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
      end
    end, { desc = 'toggle inlay hints' })
  end,
}
