return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'williamboman/mason-lspconfig.nvim',
    'williamboman/mason.nvim',

    -- generic LSP for diagnostic, formatting, etc
    'jose-elias-alvarez/null-ls.nvim',

    -- required for null-ls refactoring module
    'ThePrimeagen/refactoring.nvim',
  },
  config = function()
    local lsp = vim.lsp
    local hdls = lsp.handlers
    local telescope = require('telescope.builtin')
    local utils = require('utils')

    -- Add additional capabilities supported by nvim-cmp
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
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

    local attacher = function(client, bufnr)
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

      print('LSP: ' .. client.name)
    end

    local lspconfig = require('lspconfig')
    local customizations = require('plugins.lsp.customizations')
    local my_servers = require('plugins.lsp.installer')
    local default_opts = {
      single_file_support = true,
      on_attach = attacher,
      capabilities = capabilities,
    }

    require('plugins.lsp.generics').setup()
    require('mason').setup({
      ui = {
        border = 'none',
        icons = {
          server_installed = Theme.icons.info,
          server_pending = Theme.icons.warn,
          server_uninstalled = Theme.icons.error,
        },
      },
    })
    require('mason-lspconfig').setup()
    require('mason-tool-installer').setup({
      ensure_installed = vim.tbl_keys(my_servers),
      auto_update = false,
      run_on_start = false,
    })

    for _, server in pairs(my_servers) do
      local settings = customizations[server] or {}

      lspconfig[server].setup(vim.tbl_extend('keep', settings, default_opts))
    end

    -- Auto format files
    vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
      pattern = '*.lua,*.go,*.rb,*.json,*.js',
      callback = function()
        lsp.buf.format({ async = false })
      end,
    })
  end,
}
