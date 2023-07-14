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
  builtin.code_actions.gitsigns,
  builtin.code_actions.refactoring,
  builtin.code_actions.shellcheck,

  -- diagnostics
  builtin.diagnostics.golangci_lint,
  builtin.diagnostics.markdownlint,
  builtin.diagnostics.shellcheck,
  builtin.diagnostics.tidy,
  builtin.diagnostics.trail_space,
  builtin.diagnostics.zsh,
  conditional_rubocop,

  -- formatting
  builtin.formatting.jq,
  builtin.formatting.shfmt,
  builtin.formatting.stylua,
  builtin.formatting.tidy,

  -- hover
  builtin.hover.dictionary,
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
