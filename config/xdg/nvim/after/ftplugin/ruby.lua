local utils = require('utils')

vim.b.autoformat = false

-- Add rails standard(and gitlab) to the path for easy file jump
vim.opt_local.path:append({
  '',
  'app/**/*',
  'config/**/*',
  'lib/**/*',
  'db/**/*',
})

-- Testing
vim.g['test#ruby#use_binstubs'] = 0
vim.g['test#ruby#use_spring_binstub'] = 1

-- Run rspec even when not in a test file
vim.api.nvim_create_user_command('RSpec', function(c)
  local _, lnum, col = utils.table.unpack(vim.fn.getcurpos())
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
