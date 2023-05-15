local lspconfig = require('lspconfig')
local lsp_package = require('mason-lspconfig.mappings.server').package_to_lspconfig

--- Find lsp server personal customizations or return empty table
---@param server string lsp server name
---@return table
local function customizationsFor(server)
  local ok, customizations = pcall(require, 'plugins.lsp.tools.customizations.' .. server)

  if not ok then
    return {}
  end

  return customizations
end

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
    lspconfig[server].setup(vim.tbl_extend('keep', customizationsFor(server), opts))
  end
end

return M
