return {
  setup = function(lsp, bufnr, keymap)
    local telescope = require('telescope.builtin')

    keymap(bufnr, 'document symbols', 'n', 'gls', telescope.lsp_document_symbols)
    keymap(bufnr, 'workspace symbols', 'n', 'glS', telescope.lsp_dynamic_workspace_symbols)

    keymap(bufnr, 'definitions', 'n', 'gd', lsp.buf.definition)

    keymap(bufnr, 'definitions', 'n', 'glt', function()
      telescope.lsp_type_definitions({ jump_type = 'never' })
    end)

    keymap(bufnr, 'definitions', 'n', 'gld', function()
      telescope.lsp_definitions({ jump_type = 'never' })
    end)

    keymap(bufnr, 'references', 'n', 'glr', function()
      telescope.lsp_references({ jump_type = 'never' })
    end)

    keymap(bufnr, 'implementations', 'n', 'gli', function()
      telescope.lsp_implementations({ jump_type = 'never' })
    end)
  end,
}
