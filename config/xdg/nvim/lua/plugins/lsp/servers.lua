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
  stimulus_ls = {},
  tailwindcss = {},
  volar = require('plugins.lsp.servers.volar'), -- vuejs
  yamlls = require('plugins.lsp.servers.yamlls'),
}

vim.lsp.config('*', {
  root_markers = { '.git' },
})

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

    vim.lsp.enable({
      'lua_ls',
      'ruby_lsp',
    })
  end,
}
