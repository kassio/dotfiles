local capabilities = require('plugins.lsp.capabilities')

local servers = {
  bashls = {},
  cssls = {},
  dockerls = {},
  jqls = {},
  jsonls = {},
  jsonnet_ls = {},
  lua_ls = require('plugins.lsp.servers.lua'),
  rubocop = {},
  ruby_lsp = require('plugins.lsp.servers.ruby'),
  sqlls = {},
  yamlls = require('plugins.lsp.servers.yaml'),
  efm = require('plugins.lsp.servers.efm'),
}

return {
  servers = servers,
  setup = function()
    for server, opts in pairs(servers) do
      local config = vim.tbl_deep_extend('force', opts, {
        single_file_support = true,
        capabilities = capabilities,
      })

      vim.lsp.config(server, config)
    end
  end,
}
