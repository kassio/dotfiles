local capabilities = vim.tbl_deep_extend(
  'force',
  vim.lsp.protocol.make_client_capabilities(),
  require('blink.cmp').get_lsp_capabilities({}, false)
)

return vim.tbl_deep_extend('force', capabilities, {
  textDocument = {
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    },
    completion = {
      completionItem = {
        commitCharactersSupport = true,
        deprecatedSupport = true,
        insertReplaceSupport = true,
        labelDetailsSupport = true,
        preselectSupport = true,
        snippetSupport = true,
        documentationFormat = {
          'markdown',
          'plaintext',
        },
        resolveSupport = {
          properties = {
            'documentation',
            'detail',
            'additionalTextEdits',
          },
        },
        tagSupport = {
          valueSet = {
            1,
          },
        },
      },
    },
  },
})
