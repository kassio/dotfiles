local capabilities = require('cmp_nvim_lsp').default_capabilities()
local completionItem = capabilities.textDocument.completion.completionItem

completionItem.commitCharactersSupport = true
completionItem.deprecatedSupport = true
completionItem.insertReplaceSupport = true
completionItem.labelDetailsSupport = true
completionItem.preselectSupport = true
completionItem.snippetSupport = true

completionItem.documentationFormat = {
  'markdown',
  'plaintext',
}

completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  },
}

completionItem.tagSupport = {
  valueSet = { 1 },
}

return capabilities
