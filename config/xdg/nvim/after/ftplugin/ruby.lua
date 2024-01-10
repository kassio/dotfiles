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

vim.api.nvim_create_user_command('CopyFileNamespace', function(cmd)
  local file_namespace = utils.ruby.file_namespace()
  if file_namespace ~= '' then
    utils.to_clipboard(file_namespace, cmd.bang)
  else
    vim.notify("Can't find current file namespace", vim.log.levels.WARN, { title = 'ruby' })
  end
end, { bang = true })

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
