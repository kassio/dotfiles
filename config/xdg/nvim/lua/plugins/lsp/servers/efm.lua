local function rubocop()
  local config = require('efmls-configs.linters.rubocop')
  local fs = require('efmls-configs.fs')
  local cmd = fs.executable('rubocop', fs.Scope.BUNDLE)

  config.lintCommand = string.format('%s --format emacs --stdin "${INPUT}"', cmd)
  config.lintCategoryMap = {
    A = 'H', -- autocorrect
    C = 'I', -- convention
    E = 'E', -- error
    F = 'E', -- fatal
    I = 'I', -- info
    R = 'H', -- refactor
    W = 'W', -- warning
  }

  return config
end

local languages = {
  lua = {
    require('efmls-configs.formatters.stylua'),
  },
  go = {
    require('efmls-configs.linters.golangci_lint'),
  },
  ruby = {
    rubocop(),
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
