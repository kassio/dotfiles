local nullls = require('null-ls')
local builtins = require('null-ls.builtins')

local sources = {
  -- code actions
  builtins.code_actions.gitsigns,
  builtins.code_actions.refactoring,
  require('none-ls-shellcheck.code_actions'),

  -- diagnostics
  builtins.diagnostics.checkmake,
  builtins.diagnostics.editorconfig_checker,
  builtins.diagnostics.golangci_lint,
  require('none-ls-luacheck.diagnostics.luacheck').with({
    extra_args = {
      '--globals',
      'vim',
    },
  }),
  builtins.diagnostics.markdownlint,

  builtins.diagnostics.tidy,
  builtins.diagnostics.trail_space,
  builtins.diagnostics.zsh,
  require('none-ls.diagnostics.eslint'),
  require('none-ls-shellcheck.diagnostics'),

  -- formatting
  builtins.formatting.pg_format,
  builtins.formatting.prettier,
  builtins.formatting.shfmt,
  builtins.formatting.stylua,
  builtins.formatting.tidy,
  require('none-ls.formatting.jq'),

  -- hover
  builtins.hover.dictionary,
  builtins.hover.printenv,
}

return {
  setup = function()
    nullls.setup({
      diagnostics_format = '#{s}: [#{c}] #{m}', -- c: code, m: message, s: source
      sources = sources,
      default_timeout = 10000,
      fallback_severity = vim.diagnostic.severity.WARN,
    })
  end,
}
