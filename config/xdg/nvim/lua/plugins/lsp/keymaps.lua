local function keymap(bufnr, desc, mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, {
    silent = true,
    buffer = bufnr,
    desc = 'lsp: ' .. desc,
  })
end

return {
  setup = function(lsp, bufnr)
    keymap(bufnr, 'hover', 'n', 'K', lsp.buf.hover)
    keymap(bufnr, 'signature help', 'n', '<c-k>', lsp.buf.signature_help)
    keymap(bufnr, 'rename', 'n', 'grr', lsp.buf.rename)
    keymap(bufnr, 'format (sync)', 'n', 'glf', '<cmd>LspFormat<cr>')
    keymap(bufnr, 'format (sync)', 'n', '<leader>f=', '<cmd>LspFormat<cr>')
    keymap(bufnr, 'code actions', { 'n', 'v', 'x' }, 'gla', lsp.buf.code_action)
    keymap(bufnr, 'declarations', 'n', 'glD', lsp.buf.declaration)

    require('integrations.telescope.lsp').setup(lsp, bufnr, keymap)
  end,
}
