vim.b.skip_autoformat = true

-- Add rails standard(and gitlab) to the path for easy file jump
vim.opt_local.path:append({
  'app/channels',
  'app/components',
  'app/controllers',
  'app/enums',
  'app/events',
  'app/experiments',
  'app/finders',
  'app/graphql',
  'app/helpers',
  'app/mailers',
  'app/models',
  'app/policies',
  'app/presenters',
  'app/serializers',
  'app/services',
  'app/uploaders',
  'app/validators',
  'app/workers',
  'lib',
})

local utils = require('utils')

local function ruby_cmd(name, replacer, desc)
  vim.api.nvim_create_user_command(name, function(cmd)
    utils.buffers.preserve(function()
      vim.cmd(string.format('keeppatterns silent! %s,%s%s/e', cmd.line1, cmd.line2, replacer))
    end)
  end, { range = true, desc = desc })
end

ruby_cmd('ModernizeHashSymbolKey', [[s/:\(\w\+\)\s*=>\s*\ze/\1:\ ]], 'ruby: { :a => 1 } to { a: 1}')
ruby_cmd(
  'SymbolifyHashStringKeys',
  [[s/\(['"]\)\([^\1]\{-\}\)\1\s*\(=>\|:\)/\2:]],
  'ruby: { "a" => 1 } to { a: 1 }'
)
ruby_cmd(
  'StringifyHashSymbolKeys',
  [[s/\(\w\+\)\%(:\|\s*=>\)/'\1' =>]],
  'ruby: { a: 1 } to { "a" => 1 }'
)
ruby_cmd(
  'LetToVar',
  [[s/\<let\%(!\|\w\+\)\?(:\(\w\+\))\s*{\s*\(.\{-\}\)\s*}/\1 = \2]],
  'ruby: let(:foo) { value } to foo = value'
)
ruby_cmd(
  'VarToLet',
  [[s/@\?\(\w\+\)\s*=\s*\(.*\)/let(:\1) { \2 }]],
  'ruby: foo = value to let(:foo) { value }'
)

-- Run rspec even when not in a test file
vim.api.nvim_create_user_command('RSpec', function(c)
  local _, lnum, col = table.unpack(vim.fn.getcurpos())
  local file = c.args

  if file == '' then
    file = vim.fn.expand('%')
  end

  vim.g['test#last_strategy'] = 'terminal'
  vim.g['test#last_command'] = string.format('bundle exec rspec %s:%s:%s', file, lnum, col)

  vim.cmd.TestLast()
end, { nargs = '?', desc = 'Run rspec tests' })
vim.cmd.cabbrev('Rspec RSpec')

-- Make # add/find/remove #{,} pairs
require('nvim-surround').buffer_setup({
  surrounds = {
    ['#'] = {
      add = { '#{', '}' },
      find = '(#{)[^}]-(})',
      delete = '(#{)()[^}]-(})()',
    },
  },
})
