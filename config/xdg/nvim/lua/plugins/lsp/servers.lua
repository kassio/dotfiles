local lspconfig = require('lspconfig')
local capabilities = require('plugins.lsp.capabilities')

local servers = {
  bashls = {},
  cssls = {},
  dockerls = {},
  gopls = require('plugins.lsp.servers.gopls'),
  jqls = {},
  jsonls = {},
  jsonnet_ls = {},
  lua_ls = require('plugins.lsp.servers.lua_ls'),
  ruby_lsp = require('plugins.lsp.servers.ruby_lsp'),
  stimulus_ls = {},
  tailwindcss = {},
  volar = require('plugins.lsp.servers.volar'), -- vuejs
  yamlls = require('plugins.lsp.servers.yamlls'),
}

return {
  setup = function()
    for server, opts in pairs(servers) do
      local config = vim.tbl_deep_extend('force', opts, {
        single_file_support = true,
        capabilities = capabilities,
      })

      lspconfig[server].setup(config)
    end

    require('plugins.lsp.servers.generic').setup()
  end,
}
