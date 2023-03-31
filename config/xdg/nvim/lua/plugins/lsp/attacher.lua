local telescope = require('telescope.builtin')
local lsp = vim.lsp

local keymap = function(bufnr, desc, mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, {
    silent = true,
    buffer = bufnr,
    desc = 'lsp: ' .. desc,
  })
end

return function(_client, bufnr)
  keymap(bufnr, 'hover', 'n', 'K', lsp.buf.hover)
  keymap(bufnr, 'signature help', 'n', '<c-k>', lsp.buf.signature_help)
  keymap(bufnr, 'rename', 'n', 'grr', lsp.buf.rename)
  keymap(bufnr, 'format (sync)', 'n', 'glf', lsp.buf.format)
  keymap(bufnr, 'code actions', { 'n', 'v', 'x' }, 'gla', lsp.buf.code_action)
  keymap(bufnr, 'declarations', 'n', 'glD', lsp.buf.declaration)

  keymap(bufnr, 'document symbols', 'n', 'gls', telescope.lsp_document_symbols)
  keymap(bufnr, 'workspace symbols', 'n', 'glS', telescope.lsp_dynamic_workspace_symbols)

  keymap(bufnr, 'definitions', 'n', 'gld', function()
    telescope.lsp_definitions({ jump_type = 'never' })
  end)

  keymap(bufnr, 'references', 'n', 'glr', function()
    telescope.lsp_references({ jump_type = 'never' })
  end)

  keymap(bufnr, 'implementations', 'n', 'gli', function()
    telescope.lsp_implementations({ jump_type = 'never' })
  end)
end
