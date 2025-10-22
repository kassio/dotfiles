local global_config = {
  single_file_support = true
}

local servers = {
  bashls = {},
  cssls = {},
  dockerls = {},
  gitlab_ci_ls = {},
  gitlab_lsp = require('plugins.lsp.servers.gitlab_lsp'),
  jqls = {},
  jsonls = {},
  jsonnet_ls = {},
  lua_ls = require('plugins.lsp.servers.lua_ls'),
  rubocop = {},
  ruby_lsp = require('plugins.lsp.servers.ruby_lsp'),
  sqlls = {},
  yamlls = require('plugins.lsp.servers.yamlls'),
}

local setup = function()
  for server, user_config in pairs(servers) do
    local ok, default_config = pcall(require, 'lspconfig.configs.'..server)
    if not ok then
      default_config = {}
    end

    vim.lsp.config(server, vim.tbl_deep_extend(
      'force',
      default_config, -- Default configuration per server
      global_config, -- Personal global configuration for all servers
      user_config -- Custom configuration per server
    ))

    vim.lsp.enable(server)
  end

  vim.lsp.config('*', {
    capabilities = require('plugins.completion.capabilities')
  })
end

return {
  servers = servers,
  setup = setup
}
