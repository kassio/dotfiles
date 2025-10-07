local capabilities = require('plugins.lsp.capabilities')

local servers = {
  bashls = {},
  cssls = {},
  dockerls = {},
  jqls = {},
  jsonls = {},
  jsonnet_ls = {},
  lua_ls = require('plugins.lsp.servers.lua_ls'),
  rubocop = {},
  ruby_lsp = require('plugins.lsp.servers.ruby_lsp'),
  sqlls = {},
  volar = require('plugins.lsp.servers.volar'), -- vuejs
  yamlls = require('plugins.lsp.servers.yamlls'),
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

    require('plugins.lsp.servers.generic').setup()
  end,
}
