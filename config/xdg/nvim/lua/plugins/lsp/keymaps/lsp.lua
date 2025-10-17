return {
  setup = function(keymap)
    keymap('n', 'glD', vim.lsp.buf.declaration, 'declarations')
    keymap('n', 'gd', vim.lsp.buf.definition, 'definitions')

    keymap('n', 'gls', function()
      require('plugins.fuzzyfinder.commands').lsp_document_symbols()
    end, 'document symbols')

    keymap('n', 'gld', function()
      require('plugins.fuzzyfinder.commands').lsp_definitions()
    end, 'definitions')

    keymap('n', 'glr', function()
      require('plugins.fuzzyfinder.commands').lsp_references()
    end, 'references')

    keymap('n', 'gli', function()
      require('plugins.fuzzyfinder.commands').lsp_implementations()
    end, 'implementations')
  end
}
