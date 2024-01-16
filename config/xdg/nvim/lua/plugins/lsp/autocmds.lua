local utils = require('utils')

return {
  setup = function()
    local aug = vim.api.nvim_create_augroup('user:lsp', { clear = false })

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufNewFile' }, {
      group = aug,
      callback = function(args)
        local clients = vim.lsp.get_clients({ bufnr = args.buf })

        if utils.plugin_filetype() then
          vim.lsp.stop_client(clients)
        end
      end,
    })

    vim.api.nvim_create_autocmd({ 'LspAttach' }, {
      group = aug,
      callback = function(args)
        local lsp = vim.lsp
        local client = vim.lsp.get_client_by_id(args.data.client_id) or {}
        if vim.tbl_get(client, { 'server_capabilities', 'inlayHintProvider' }) ~= nil then
          lsp.inlay_hint(args.buf, false)
        end

        require('plugins.lsp.keymaps').setup(lsp, args.buf)
        require('plugins.lsp.autoformat').setup(client, args.buf)
      end,
    })
  end,
}
