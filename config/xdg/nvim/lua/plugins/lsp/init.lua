local lsp = vim.lsp
local hdls = lsp.handlers
local installer = require('plugins.lsp.installer')
local command = vim.api.nvim_create_user_command
local telescope = require('telescope.builtin')

-- Add additional capabilities supported by nvim-cmp
local protocol = lsp.protocol
local capabilities =
  require('cmp_nvim_lsp').update_capabilities(protocol.make_client_capabilities())
local completionItem = capabilities.textDocument.completion.completionItem
completionItem.documentationFormat = { 'markdown', 'plaintext' }
completionItem.snippetSupport = true
completionItem.preselectSupport = true
completionItem.insertReplaceSupport = true
completionItem.labelDetailsSupport = true
completionItem.deprecatedSupport = true
completionItem.commitCharactersSupport = true
completionItem.tagSupport = { valueSet = { 1 } }
completionItem.resolveSupport = {
  properties = { 'documentation', 'detail', 'additionalTextEdits' },
}

hdls['textDocument/hover'] = lsp.with(hdls.hover, { border = 'rounded' })
hdls['textDocument/signatureHelp'] = lsp.with(hdls.signature_help, { border = 'rounded' })

vim.keymap.set('n', '<leader>o', '<cmd>SymbolsOutline<cr>', { silent = true })

local nmap = function(lhs, rhs)
  vim.keymap.set('n', lhs, rhs, { buffer = 0, silent = true })
end

local command_map = function(fn, map, cmd_name, cmd_opts)
  cmd_opts = cmd_opts or {}
  vim.api.nvim_create_user_command(cmd_name, fn, cmd_opts)

  if map ~= nil then
    vim.keymap.set('n', map, fn)
  end
end

local attacher = function(client)
  command_map(function()
    lsp.buf.hover()
  end, 'K', 'LspHover')

  command_map(function()
    lsp.buf.signature_help()
  end, '<c-k>', 'LspSignatureHelp')

  command_map(function()
    lsp.buf.declaration()
  end, 'glD', 'LspGoToDeclaration')

  command_map(function(cmd)
    cmd = cmd or {}

    if (cmd.range or 0) > 0 then
      lsp.buf.range_code_action()
    else
      lsp.buf.code_action()
    end
  end, 'gla', 'LspCodeActions', { range = 0 })

  command_map(function()
    lsp.buf.rename()
  end, 'grr', 'LspRename')

  command_map(function()
    lsp.buf.format()
  end, 'glF', 'LspFormatSync')

  command_map(function()
    lsp.buf.format({ async = true })
  end, 'glf', 'LspFormat')

  command_map(function()
    telescope.lsp_definitions({ jump_type = 'never' })
  end, 'gld', 'LspGoToDefinition')

  command_map(function()
    telescope.lsp_references()
  end, 'glr', 'LspListReferences')

  command_map(function()
    telescope.lsp_implementations({ jump_type = 'never' })
  end, 'gli', 'LspImplementation')

  command_map(function()
    telescope.lsp_document_symbols({ show_line = true })
  end, 'gls', 'LspDocumentSymbols')

  command_map(function()
    telescope.lsp_dynamic_workspace_symbols({ show_line = true })
  end, 'glS', 'LspWorkspaceSymbols')

  print('LSP: ' .. client.name)
end

-- Configure LSPs installed by installer
installer.setup(attacher, capabilities)

-- Auto format files
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = '*.lua,*.go,*.rb,*.json,*.js',
  callback = function()
    P(lsp.buf.format)
    lsp.buf.format({ async = false })
  end,
})
