local lspconfig = require('lspconfig')
local customizations = require('plugins.lsp.customizations')
local attacher = require('plugins.lsp.attacher')
local servers_map = require('mason-lspconfig.mappings.server').package_to_lspconfig
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

local tools = table.slice(servers_map, {
  'bash-language-server',
  'css-lsp',
  'dockerfile-language-server',
  'editorconfig-checker',
  'go-debug-adapter',
  'golangci-lint',
  'golangci-lint-langserver',
  'golines',
  'gopls',
  'gotests',
  'graphql-language-service-cli',
  'html-lsp',
  'json-lsp',
  'jsonnet-language-server',
  'lua-language-server',
  'luacheck',
  'luaformatter',
  'markdownlint',
  'prettier',
  'shellcheck',
  'shfmt',
  'solargraph',
  'sql-formatter',
  'sqlls',
  'sqls',
  'stylua',
  'tailwindcss-language-server',
  'typescript-language-server',
  'vetur-vls',
  'vim-language-server',
  'vint',
  'vue-language-server',
  'yaml-language-server',
  'yamllint',
})

return {
  setup = function()
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
      ensure_installed = vim.tbl_keys(tools),
      auto_update = false,
      run_on_start = false,
    })

    local default_opts = {
      single_file_support = true,
      on_attach = attacher,
      capabilities = capabilities,
    }

    for _, server in pairs(tools) do
      local settings = customizations[server] or {}

      lspconfig[server].setup(vim.tbl_extend('keep', settings, default_opts))
    end
  end,
}
