local theme = vim.my.theme
local lspconfig = require('lspconfig')
local installer = require('mason-lspconfig')
local generics = require('plugins.lsp.generics')
local customizations = require('plugins.lsp.customizations')

require('mason').setup({
  ui = {
    border = 'none',
    icons = {
      server_installed = theme.icons.info,
      server_pending = theme.icons.warn,
      server_uninstalled = theme.icons.error,
    },
  },
})

local servers = {
  'bashls',
  'cssls',
  'gopls',
  'golangci_lint_ls',
  'graphql',
  'html',
  'jsonls',
  'solargraph',
  'sqlls',
  'sqls',
  'sumneko_lua',
  'tailwindcss',
  'vimls',
  'vuels',
  'yamlls',
}

return {
  setup = function(attacher, capabilities)
    local default_opts = {
      single_file_support = true,
      on_attach = attacher,
      capabilities = capabilities,
    }

    installer.setup({
      automatic_installation = true,
      ensure_installed = servers,
    })

    generics.setup()

    for _, server in ipairs(servers) do
      local settings = customizations[server] or {}

      lspconfig[server].setup(vim.tbl_extend('keep', settings, default_opts))
    end
  end,
}
