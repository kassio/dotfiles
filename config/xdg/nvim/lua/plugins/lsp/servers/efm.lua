local function formatter(name)
  require('efmls-configs.formatters.' .. name)
end

local function linter(name)
  require('efmls-configs.linters.' .. name)
end

local languages = {
  lua = {
    formatter('stylua'),
  },
  go = {
    linter('golangci_lint'),
  },
  sh = {
    formatter('shfmt'),
    linter('shellcheck'),
  },
  sql = {
    formatter('sql-formatter'),
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
    logFile = vim.lsp.get_log_path(),
    languages = languages,
    rootMarkers = { '.git/' },
  },
}
