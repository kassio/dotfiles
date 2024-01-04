local utils = require('utils')

return {
  setup = function()
    local aug = vim.api.nvim_create_augroup('user:lsp', { clear = false })

    vim.api.nvim_create_autocmd({ 'LspAttach' }, {
      group = aug,
      callback = function(args)
        local lsp = vim.lsp
        local client = vim.lsp.get_client_by_id(args.data.client_id) or {}
        if vim.tbl_get(client, { 'server_capabilities', 'inlayHintProvider' }) ~= nil then
          lsp.inlay_hint(args.buf, false)
        end

        require('plugins.lsp.keymaps').setup(lsp, args.buf)
        require('plugins.lsp.autoformat').setup()
      end,
    })
  end,
}
