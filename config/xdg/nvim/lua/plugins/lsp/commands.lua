local utils = require('utils')

local function format(bufnr, async)
  local filetype = vim.bo[bufnr].filetype
  if
    not vim.bo[bufnr].modifiable
    or filetype == ''
    or utils.plugin_filetype(filetype)
    or vim.b[bufnr].skip_autoformat == true
  then
    return
  end

  vim.lsp.buf.format({ async = async == true })
end

return {
  setup = function(bufnr)
    require('plugins.lsp.servers.ruby_ls.commands').setup(bufnr)

    vim.api.nvim_buf_create_user_command(bufnr, 'LspFormat', function(opts)
      local sync = opts.bang
      format(bufnr, not sync)
    end, { bang = true, desc = 'lsp: async format document. [! for sync format]' })

    vim.api.nvim_buf_create_user_command(bufnr, 'LspToggleInlayHint', function()
      local inlay_enabled = not vim.lsp.inlay_hint.is_enabled()

      vim.lsp.inlay_hint.enable(bufnr, inlay_enabled)
      vim.b[bufnr].inlay_enabled = inlay_enabled
    end, {})
  end,
}
