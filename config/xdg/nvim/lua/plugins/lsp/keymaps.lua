local function keymap_generator(bufnr)
  return function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, {
      silent = true,
      buffer = bufnr,
      desc = 'lsp: ' .. desc,
    })
  end
end

return {
  setup = function(bufnr)
    local lsp_utils = require('plugins.lsp.utils')
    local keymap = keymap_generator(bufnr)

    keymap('n', '<leader>f=', function()
      lsp_utils.format(bufnr)
    end, 'format')

    keymap('n', '<c-k>', vim.lsp.buf.signature_help, 'signature help')

    keymap('n', 'grr', vim.lsp.buf.rename, 'rename')
    keymap({ 'n', 'v', 'x' }, 'gla', vim.lsp.buf.code_action, 'code actions')

    keymap('n', 'glD', vim.lsp.buf.declaration, 'declarations')
    keymap('n', 'gd', vim.lsp.buf.definition, 'definitions')

    keymap('n', 'gls', lsp_utils.document_symbols, 'document symbols')

    keymap('n', 'gld', lsp_utils.definitions, 'definitions')

    keymap('n', 'glr', lsp_utils.references, 'references')

    keymap('n', 'gli', lsp_utils.implementations, 'implementations')
  end,
}
