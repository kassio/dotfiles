return {
  setup = function()
    local lsp = vim.lsp
    local handlers = lsp.handlers

    handlers['textDocument/hover'] = lsp.with(handlers.hover, {
      border = 'rounded',
    })

    handlers['textDocument/signatureHelp'] = lsp.with(handlers.signature_help, {
      border = 'rounded',
    })
  end,
}
