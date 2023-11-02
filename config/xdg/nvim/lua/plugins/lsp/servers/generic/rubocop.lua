local builtin = require('null-ls.builtins')
local conditionals = require('null-ls.utils').make_conditional_utils()

return function()
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
