local utils = require('utils')

return {
  setup = function()
    vim.api.nvim_create_autocmd({ 'LspAttach' }, {
      group = vim.api.nvim_create_augroup('user:lsp:attach', { clear = false }),
      callback = function(args)
        local bufnr = args.buf
        if utils.plugin_filetype(vim.bo[bufnr].filetype) then
          -- Ensure to not run LSP on plugin buffers
          return vim.cmd.LspStop()
        end

        local lsp = vim.lsp
        local client = vim.lsp.get_client_by_id(args.data.client_id) or {}
        if vim.tbl_get(client, { 'server_capabilities', 'inlayHintProvider' }) ~= nil then
          lsp.inlay_hint(bufnr, false)
        end

        require('plugins.lsp.keymaps').setup(lsp, bufnr)
        require('plugins.lsp.autoformat').setup()
      end,
    })
  end,
}
