local lspconfig = require('lspconfig')
local servers_map = require('mason-lspconfig.mappings.server').package_to_lspconfig
local generics = require('plugins.lsp.generics')
local theme = require('plugins.highlight.theme')
local customizations = require('plugins.lsp.customizations')

local my_servers = table.slice(servers_map, {
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

require('mason').setup({
  ui = {
    border = 'none',
    icons = {
      server_installed = theme.icons.info,
      server_pending = theme.icons.warn,
      server_uninstalled = theme.icons.error,
    },
  },
})

require('mason-lspconfig').setup()

require('mason-tool-installer').setup({
  ensure_installed = vim.tbl_keys(my_servers),
  auto_update = false,
  run_on_start = false,
})

return {
  setup = function(attacher, capabilities)
    local default_opts = {
      single_file_support = true,
      on_attach = attacher,
      capabilities = capabilities,
    }

    generics.setup()

    for _, server in pairs(my_servers) do
      local settings = customizations[server] or {}

      lspconfig[server].setup(vim.tbl_extend('keep', settings, default_opts))
    end
  end,
}
