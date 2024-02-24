local utils = require('utils')

local function can_format()
  local filetype = vim.bo.filetype

  return vim.bo.modifiable
    and filetype ~= ''
    and not utils.plugin_filetype(filetype)
    and vim.b.skip_autoformat ~= true
end

return {
  setup = function()
    require('plugins.lsp.servers.ruby_ls.commands').setup()

    vim.api.nvim_create_user_command('LspFormat', function()
      if not can_format() then
        return
      end

      for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
        vim.lsp.buf.format({ name = client.name, async = false })
      end
    end, { desc = 'lsp: format document' })

    vim.api.nvim_create_user_command('LspToggleInlayHint', function()
      local has_inlay = vim.tbl_contains(vim.lsp.get_clients({ bufnr = 0 }), function(client)
        return client.server_capabilities.inlayHintProvider
      end)

      if has_inlay then
        vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
      end
    end, { desc = 'lsp: toggle inlay hints' })
  end,
}
