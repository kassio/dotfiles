local lspconfig = require('lspconfig')
local customizations = require('plugins.lsp.tools.customizations')
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
  'rust-analyzer',
  'rustfmt',
  'shellcheck',
  'shfmt',
  'solargraph',
  'sql-formatter',
  'sqlls',
  'stylua',
  'tailwindcss-language-server',
  'typescript-language-server',
  'vetur-vls',
  'vim-language-server',
  'vue-language-server',
  'yaml-language-server',
})

local M = {}

M.packages = vim.tbl_keys(map)
M.lsps = vim.tbl_values(map)

--- Setup all lsp servers
---@param opts table default setup opts to be merged with tools/customizations
M.setup = function(opts)
  for _, server in ipairs(M.lsps) do
    local settings = customizations[server] or {}

    lspconfig[server].setup(vim.tbl_extend('keep', settings, opts))
  end
end

return M
