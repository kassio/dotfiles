local function keymap(bufnr, desc, mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, {
    silent = true,
    buffer = bufnr,
    desc = 'lsp: ' .. desc,
  })
end

return {
  setup = function()
    vim.api.nvim_create_autocmd({ 'LspAttach' }, {
      group = vim.api.nvim_create_augroup('user:lsp:attach', { clear = false }),
      callback = function(args)
        local lsp = vim.lsp
        local bufnr = args.buf

        local client = vim.lsp.get_client_by_id(args.data.client_id) or {}
        if vim.tbl_get(client, { 'server_capabilities', 'inlayHintProvider' }) ~= nil then
          lsp.inlay_hint(bufnr, false)
        end

        keymap(bufnr, 'hover', 'n', 'K', lsp.buf.hover)
        keymap(bufnr, 'signature help', 'n', '<c-k>', lsp.buf.signature_help)
        keymap(bufnr, 'rename', 'n', 'grr', lsp.buf.rename)
        keymap(bufnr, 'format (sync)', 'n', 'glf', '<cmd>LspFormat<cr>')
        keymap(bufnr, 'format (sync)', 'n', '<leader>f=', '<cmd>LspFormat<cr>')
        keymap(bufnr, 'code actions', { 'n', 'v', 'x' }, 'gla', lsp.buf.code_action)
        keymap(bufnr, 'declarations', 'n', 'glD', lsp.buf.declaration)

        require('integrations.telescope.lsp').setup(lsp, bufnr, keymap)
      end,
    })
  end,
}
