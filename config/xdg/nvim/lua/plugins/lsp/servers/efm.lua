local languages = {
  lua = {
    require('efmls-configs.formatters.stylua'),
  },
  go = {
    require('efmls-configs.linters.golangci_lint'),
  },
  ruby = {
    require('efmls-configs.linters.rubocop'),
  },
  sh = {
    require('efmls-configs.formatters.shfmt'),
    require('efmls-configs.linters.shellcheck'),
  },
}

return {
  filetypes = vim.tbl_keys(languages),
  settings = {
    logLevel = 4,
    logFile = vim.lsp.get_log_path(),
    languages = languages,
  },
  init_options = {
    codeAction = true,
    completion = true,
    documentFormatting = true,
    documentRangeFormatting = true,
    documentSymbol = true,
    hover = true,
  },
}
