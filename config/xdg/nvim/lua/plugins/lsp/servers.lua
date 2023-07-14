local lspconfig = require('lspconfig')
local capabilities = require('plugins.lsp.capabilities')

local function config(server, defaults)
  local ok, cfg = pcall(require, 'plugins.lsp.servers.' .. server)

  if not ok then
    return defaults
  end

  return vim.tbl_deep_extend('force', defaults, cfg)
end

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = {
  'bashls', -- bash - via brew bash-language-server
  'cssls', -- css - via brew vscode-langservers-extracted
  'gopls', -- go - via go/default_packages
  'jsonls', -- json - via brew vscode-langservers-extracted
  'jsonnet_ls', -- jsonnet - via go/default_packages
  'jqls', -- jq - via go/default_packages
  'lua_ls', -- lua - via brew lua-language-server
  'solargraph', -- ruby - via rubygems
  'sqlls', -- sql - via brew sql-language-server
  'yamlls', -- yaml - via brew yaml-language-server
}

return {
  setup = function()
    for _, server in pairs(servers) do
      local cfgs = config(server, {
        single_file_support = true,
        capabilities = capabilities,
      })

      lspconfig[server].setup(cfgs)
    end
  end,
}
