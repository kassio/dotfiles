local languages = {
  lua = {
    require('efmls-configs.formatters.stylua'),
  },
  go = {
    require('efmls-configs.linters.golangci_lint'),
  },
  ruby = {
    require('plugins.lsp.servers.efm.rubocop'),
  },
  sh = {
    require('efmls-configs.formatters.shfmt'),
    require('efmls-configs.linters.shellcheck'),
  },
}

return {
  filetypes = vim.tbl_keys(languages),
  init_options = {
    codeAction = true,
    completion = true,
    documentFormatting = true,
    documentRangeFormatting = true,
    documentSymbol = true,
    hover = true,
  },
  settings = {
    logLevel = vim.lsp.log_levels.INFO,
    logFile = vim.lsp.get_log_path(),
    languages = languages,
    rootMarkers = { '.git/' },
  },
}
