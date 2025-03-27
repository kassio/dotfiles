local capabilities = require('plugins.lsp.capabilities')

return {
  setup = function()
    vim.lsp.config('*', {
      root_markers = { '.git' },
      single_file_support = true,
      capabilities = capabilities,
    })

    vim.lsp.enable({
      'gopls',
      'lua_ls',
      'ruby_lsp',
      'volar',
      'yamlls',
    })

    require('plugins.lsp.servers.generic').setup()
  end,
}
