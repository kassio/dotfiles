local lsp = vim.lsp
local handlers = lsp.handlers

return {
  setup = function()
    handlers['textDocument/hover'] = lsp.with(handlers.hover, {
      border = 'rounded',
    })

    handlers['textDocument/signatureHelp'] = lsp.with(handlers.signature_help, {
      border = 'rounded',
    })
  end,
}
