return {
  setup = function(lsp, bufnr)
    local function keymap(desc, mode, lhs, rhs)
      vim.keymap.set(mode, lhs, rhs, {
        silent = true,
        buffer = bufnr,
        desc = 'lsp: ' .. desc,
      })
    end

    keymap('hover', 'n', 'K', lsp.buf.hover)
    keymap('signature help', 'n', '<c-k>', lsp.buf.signature_help)
    keymap('rename', 'n', 'grr', lsp.buf.rename)
    keymap('format (sync)', 'n', 'glf', '<cmd>LspFormat<cr>')
    keymap('format (sync)', 'n', '<leader>f=', '<cmd>LspFormat<cr>')
    keymap('code actions', { 'n', 'v', 'x' }, 'gla', lsp.buf.code_action)
    keymap('declarations', 'n', 'glD', lsp.buf.declaration)

    require('plugins.fuzzyfinder.lsp').setup(lsp, keymap)
  end,
}
