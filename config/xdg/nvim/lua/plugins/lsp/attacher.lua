local utils = require('utils')
local telescope = require('telescope.builtin')
local lsp = vim.lsp

return function(client, bufnr)
  utils.keycmds({
    prefix = 'Lsp',
    list = {
      {
        cmd = 'Hover',
        key = 'K',
        opts = { buffer = bufnr },
        fn = lsp.buf.hover,
      },
      {
        cmd = 'SignatureHelp',
        key = '<c-k>',
        opts = { buffer = bufnr },
        fn = lsp.buf.signature_help,
      },
      {
        cmd = 'GoToDeclaration',
        key = 'glD',
        opts = { buffer = bufnr },
        fn = lsp.buf.declaration,
      },
      {
        cmd = 'Rename',
        key = 'grr',
        opts = { buffer = bufnr },
        fn = lsp.buf.rename,
      },
      {
        cmd = 'FormatSync',
        key = 'glF',
        opts = { buffer = bufnr },
        fn = lsp.buf.format,
      },
      {
        cmd = 'DocumentSymbols',
        key = 'gls',
        opts = { buffer = bufnr },
        fn = telescope.lsp_document_symbols,
      },
      {
        cmd = 'WorkspaceSymbols',
        key = 'glS',
        opts = { buffer = bufnr },
        fn = telescope.lsp_dynamic_workspace_symbols,
      },
      {
        cmd = 'CodeActions',
        key = 'gla',
        opts = { buffer = bufnr, range = 0 },
        fn = function(cmd)
          cmd = cmd or {}

          if (cmd.range or 0) > 0 then
            lsp.buf.range_code_action()
          else
            lsp.buf.code_action()
          end
        end,
      },
    },
    {
      cmd = 'Format',
      key = 'glf',
      opts = { buffer = bufnr },
      fn = function()
        lsp.buf.format({ async = true })
      end,
    },
    {
      cmd = 'GoToDefinition',
      key = 'gld',
      opts = { buffer = bufnr },
      fn = function()
        telescope.lsp_definitions({ jump_type = 'never' })
      end,
    },
    {
      cmd = 'ListReferences',
      key = 'glr',
      opts = { buffer = bufnr },
      function()
        telescope.lsp_references({ jump_type = 'never' })
      end,
    },
    {
      cmd = 'Implementation',
      key = 'gli',
      opts = { buffer = bufnr },
      fn = function()
        telescope.lsp_implementations({ jump_type = 'never' })
      end,
    },
  })

  vim.notify(client.name .. ' loaded', nil, { title = 'LSP' })
end
