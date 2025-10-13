local ffinder = require('fzf-lua')
return {
  lsp_definitions = function()
    ffinder.lsp_definitions()
  end,
  lsp_document_symbols = function()
    ffinder.lsp_document_symbols()
  end,
  lsp_implementations = function()
    ffinder.lsp_implementations()
  end,
  lsp_references = function()
    ffinder.lsp_references()
  end,
}
