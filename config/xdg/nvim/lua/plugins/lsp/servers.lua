local lspconfig = require('lspconfig')
local capabilities = require('plugins.lsp.capabilities')

--- Find lsp server personal customizations or return empty table
---@param server string lsp server name
---@return table
local function config(server)
  local ok, cfg = pcall(require, 'plugins.lsp.servers.' .. server)

  if not ok then
    return {}
  end

  return cfg
end

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = {
  'bashls', -- via brew bash-language-server
  'cssls', -- via brew vscode-langservers-extracted
  'gopls', -- via go/default_packages
  'jsonls', -- via brew vscode-langservers-extracted
  'jsonnet_ls', -- via go/default_packages
  'lua_ls', -- via brew lua-language-server
  'solargraph', -- via ruby
  'sqlls', -- via brew sql-language-server
  'yamlls', -- via brew yaml-language-server
}

return {
  setup = function()
    for _, server in pairs(servers) do
      cfgs = vim.tbl_extend('keep', config(server), {
        single_file_support = true,
        capabilities = capabilities,
      })

      lspconfig[server].setup(cfgs)
    end
  end,
}
