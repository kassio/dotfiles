return {
  setup = function()
    vim.api.nvim_create_autocmd({ 'LspAttach' }, {
      callback = function(opts)
        local lsp_methods = vim.lsp.protocol.Methods
        local bufnr = opts.buf
        local client = vim.lsp.get_client_by_id(opts.data.client_id)

        require('plugins.lsp.keymaps').setup(client, bufnr)

        if vim.bo[bufnr].modifiable and
          vim.b[bufnr].autoformat ~= false and
          client and not
          client:supports_method(lsp_methods.textDocument_willSaveWaitUntil) and
          client:supports_method(lsp_methods.textDocument_formatting) then

          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            callback = function()
              require('plugins.lsp.utils').format(bufnr)
            end,
          })
        end
      end
    })
  end,
}
