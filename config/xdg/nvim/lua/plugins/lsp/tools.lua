local lsp_package = require('mason-lspconfig.mappings.server').package_to_lspconfig

local map = table.slice(lsp_package, {
  'bash-language-server',
  'css-lsp',
  'dockerfile-language-server',
  'golangci-lint',
  'gopls',
  'graphql-language-service-cli',
  'html-lsp',
  'jq',
  'json-lsp',
  'jsonnet-language-server',
  'lua-language-server',
  'rubocop',
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
  'vue-language-server',
  'yaml-language-server',
  'yamlfmt',
  'yamllint',
})

return {
  packages = vim.tbl_keys(map),
  lsps = vim.tbl_values(map),
}
