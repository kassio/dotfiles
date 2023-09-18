local lspconfig = require('lspconfig')
local capabilities = require('plugins.lsp.capabilities')

local servers = {
  bashls = {},
  cssls = {},
  efm = require('plugins.lsp.servers.efm'),
  gopls = require('plugins.lsp.servers.gopls'),
  jqls = {},
  jsonls = {},
  jsonnet_ls = {},
  lua_ls = require('plugins.lsp.servers.lua_ls'),
  solargraph = require('plugins.lsp.servers.solargraph'),
  sqlls = {},
  yamlls = require('plugins.lsp.servers.yamlls'),
}

return {
  setup = function()
    for server, opts in pairs(servers) do
      local config = vim.tbl_deep_extend('force', opts or {}, {
        single_file_support = true,
        capabilities = capabilities,
      })

      lspconfig[server].setup(config)
    end
  end,
}
