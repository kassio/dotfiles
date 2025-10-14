M = {}

local globals = {
  single_file_support = true
}

M.servers = {
  bashls = {},
  cssls = {},
  dockerls = {},
  efm = require('plugins.lsp.servers.efm'),
  gitlab_ci_ls = {},
  gitlab_lsp = require('plugins.lsp.servers.gitlab'),
  jqls = {},
  jsonls = {},
  jsonnet_ls = {},
  lua_ls = require('plugins.lsp.servers.lua'),
  rubocop = {},
  ruby_lsp = require('plugins.lsp.servers.ruby'),
  sqlls = {},
  yamlls = require('plugins.lsp.servers.yaml'),
}

M.setup = function()
  for server, opts in pairs(M.servers) do

    local ok, default = pcall(require, 'lspconfig.configs.'..server)
    if not ok then
      default = {}
    end

    vim.lsp.config(server, vim.tbl_deep_extend(
      'force',
      default, -- Default configuration per server
      globals, -- Personal global configuration for all servers
      opts -- Custom configuration per server
    ))

    vim.lsp.enable(server)
  end

  vim.lsp.config('*', {
    capabilities = require('plugins.completion.capabilities')
  })
end

return M
