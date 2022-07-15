local lspconfig = require('lspconfig')
local installer = require('nvim-lsp-installer')
local customizations = require('plugins.lsp.customizations')
local generics = require('plugins.lsp.generics')
local theme = vim.my.theme

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

local M = {}

M.setup = function(attacher, capabilities)
  local default_opts = {
    single_file_support = true,
    on_attach = attacher,
    capabilities = capabilities,
  }

  installer.setup({
    automatic_installation = true,
    ensure_installed = servers,
    ui = {
      icons = {
        server_installed = theme.signs.info,
        server_pending = theme.signs.warn,
        server_uninstalled = theme.signs.error,
      },
    },
  })

  generics.setup()

  for _, server in ipairs(servers) do
    local settings = customizations[server] or {}

    lspconfig[server].setup(vim.tbl_extend('keep', settings, default_opts))
  end
end

return M
