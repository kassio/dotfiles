local global_config = { single_file_support = true }
local packages = require('plugins.lsp.servers.packages')
local servers = vim
  .iter(packages)
  :map(function(package)
    return package.lspconfig_name
  end)
  :totable()

return {
  servers = servers,
  -- Tools used to format documents
  formattable = vim.tbl_filter(function(server)
    return not vim.tbl_contains({ 'gitlab_lsp', 'gitlab_duo' }, server)
  end, servers),
  setup = function()
    for _, server in ipairs(servers) do
      local user_ok, user_config = pcall(require, 'plugins.lsp.servers.' .. server)
      if not user_ok then
        user_config = {}
      end

      local lspconfig_ok, default_config = pcall(require, 'lspconfig.configs.' .. server)
      if not lspconfig_ok then
        default_config = {}
      end

      vim.lsp.config(
        server,
        vim.tbl_deep_extend(
          'force',
          default_config, -- Default configuration per server
          global_config, -- Personal global configuration for all servers
          user_config -- Custom configuration per server
        )
      )

      vim.lsp.enable(server)
    end

    vim.lsp.config('*', {
      capabilities = require('plugins.completion.capabilities'),
    })
  end,
}
