local capabilities = require('plugins.lsp.capabilities')

return {
  setup = function()
    vim.lsp.config('*', {
      root_markers = { '.git' },
      single_file_support = true,
      capabilities = capabilities,
    })

    vim.lsp.enable({
      'bashls',
      'cssls',
      'dockerls',
      'gopls',
      'jqls',
      'jsonls',
      'lua_ls',
      'ruby_lsp',
      'tailwindcss',
      'volar',
      'yamlls',
    })

    require('plugins.lsp.servers.generic').setup()
  end,
}
