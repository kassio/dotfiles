local nullls = require('null-ls')
local builtin = require('null-ls.builtins')
local conditionals = require('null-ls.utils').make_conditional_utils()

local conditional_rubocop = function()
  local rubocop = builtin.diagnostics.rubocop

  if conditionals.root_has_file('Gemfile') then
    return rubocop.with({
      command = 'bundle',
      args = vim.list_extend({ 'exec', 'rubocop' }, rubocop._opts.args),
    })
  else
    return rubocop
  end
end

local sources = {
  -- code actions
  builtin.code_actions.gitsigns, -- via 'lewis6991/gitsigns.nvim'
  builtin.code_actions.refactoring, -- via 'ThePrimeagen/refactoring.nvim'
  builtin.code_actions.shellcheck, -- via brew

  -- diagnostics
  builtin.diagnostics.checkmake, -- makefile - via go/default_packages
  builtin.diagnostics.editorconfig_checker, -- via go/default_packages
  builtin.diagnostics.golangci_lint, -- go - via go/default_packages
  builtin.diagnostics.luacheck.with({ -- lua - via brew
    extra_args = {
      '--globals',
      'vim',
    },
  }),
  builtin.diagnostics.markdownlint, -- markdown - via brew
  builtin.diagnostics.shellcheck, -- shell - via brew
  builtin.diagnostics.tidy, -- html - via brew
  builtin.diagnostics.trail_space, -- null-ls builtin
  builtin.diagnostics.zsh, -- zsh builtin
  conditional_rubocop, -- via rubygems

  -- formatting
  builtin.formatting.jq, -- via brew
  builtin.formatting.shfmt, -- via brew
  builtin.formatting.stylua, -- via brew
  builtin.formatting.tidy, -- via brew

  -- hover
  builtin.hover.dictionary, -- web-api
  builtin.hover.printenv, -- null-ls builtin
}

return {
  setup = function()
    nullls.setup({
      diagnostics_format = '[#{c}] #{m} (#{s})',
      sources = sources,
      default_timeout = 10000,
    })
  end,
}
