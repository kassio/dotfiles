local nullls = require('null-ls')
local builtin = require('null-ls.builtins')

local sources = {
  -- code actions
  builtin.code_actions.gitsigns, -- 'lewis6991/gitsigns.nvim'
  builtin.code_actions.refactoring, -- 'ThePrimeagen/refactoring.nvim'
  builtin.code_actions.shellcheck, -- install:brew

  -- diagnostics
  builtin.diagnostics.checkmake, -- makefile - install:go/default_packages
  builtin.diagnostics.editorconfig_checker, -- install:go/default_packages
  builtin.diagnostics.golangci_lint, -- go - install:go/default_packages
  builtin.diagnostics.luacheck.with({ -- lua - install:brew
    extra_args = {
      '--globals',
      'vim',
    },
  }),
  builtin.diagnostics.markdownlint, -- markdown - install:brew
  builtin.diagnostics.shellcheck, -- shell - install:brew
  builtin.diagnostics.tidy, -- html - install:brew
  builtin.diagnostics.trail_space, -- null-ls builtin
  builtin.diagnostics.zsh, -- zsh builtin
  require('plugins.lsp.servers.generic.rubocop'),

  -- formatting
  builtin.formatting.jq, -- install:brew
  builtin.formatting.shfmt, -- install:brew
  builtin.formatting.stylua, -- install:brew
  builtin.formatting.tidy, -- install:brew

  -- hover
  builtin.hover.dictionary, -- web-api
  builtin.hover.printenv, -- null-ls builtin
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
