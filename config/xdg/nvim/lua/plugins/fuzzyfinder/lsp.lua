return {
  setup = function(lsp, keymap)
    local telescope = require('telescope.builtin')

    keymap('document symbols', 'n', 'gls', telescope.lsp_document_symbols)
    keymap('workspace symbols', 'n', 'glS', telescope.lsp_dynamic_workspace_symbols)

    keymap('definitions', 'n', 'gd', lsp.buf.definition)

    keymap('definitions', 'n', 'glt', function()
      telescope.lsp_type_definitions({ jump_type = 'never' })
    end)

    keymap('definitions', 'n', 'gld', function()
      telescope.lsp_definitions({ jump_type = 'never' })
    end)

    keymap('references', 'n', 'glr', function()
      telescope.lsp_references({ jump_type = 'never' })
    end)

    keymap('implementations', 'n', 'gli', function()
      telescope.lsp_implementations({ jump_type = 'never' })
    end)
  end,
}
