vim.b.skip_autoformat = true

local utils = require('utils')

local ruby_cmd = function(name, replacer)
  vim.api.nvim_create_user_command('Ruby' .. name, function(cmd)
    utils.buffers.preserve(function()
      vim.cmd(string.format('silent %s,%s%s/e', cmd.line1, cmd.line2, replacer))
    end)
  end, { range = true })
end

-- { :a => 1 } to { a: 1}
ruby_cmd('ModernizeHashSymbolKey', [[s/:\(\w\+\)\s*=>\s*\ze/\1:\ ]])
-- { 'a' => 1 } to { a: 1 }
ruby_cmd('ConvertHashStringKeyToSymbol', [[s/\(['"]\)\([^\1]\{-\}\)\1\s*\(=>\|:\)/\2:]])
-- { a: 1 } to { 'a' => 1 }
ruby_cmd('ConvertHashSymbolKeyToString', [[s/\(\w\+\)\%(:\|\s*=>\)/'\1' =>]])
-- let(:foo) { value } to foo = value
ruby_cmd('LetToVar', [[s/let\%(\w\+\)\?(:\(\w\+\))\s*{\s*\(.\{-\}\)\s*}/\1 = \2]])
-- foo = value to let(:foo) { value }
ruby_cmd('VarToLet', [[s/@\?\(\w\+\)\s*=\s*\(.*\)/let(:\1) { \2 }]])

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
end, { nargs = '?' })
vim.cmd('cabbrev Rspec RSpec')

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
