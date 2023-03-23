local utils = require('utils')

local ruby_cmd = function(name, replacer)
  vim.api.nvim_create_user_command('Ruby' .. name, function(cmd)
    utils.buffers.preserve(function()
      vim.cmd(string.format('silent %s,%s%s/e', cmd.line1, cmd.line2, replacer))
    end)
  end, { range = true })
end

ruby_cmd('ModernizeHashSymbolKey', [[s/:\(\w\+\)\s*=>\s*\ze/\1:\ ]])
ruby_cmd('ConvertHashStringKeyToSymbol', [[s/\(['"]\)\([^\1]\{-\}\)\1\s*\(=>\|:\)/\2:]])
ruby_cmd('ConvertHashSymbolKeyToString', [[s/\(\w\+\)\%(:\|\s*=>\)/'\1' =>]])
ruby_cmd('LetToVar', [[s/let\%(\w\+\)\?(:\(\w\+\))\s*{\s*\(.\{-\}\)\s*}/\1 = \2]])
ruby_cmd('VarToLet', [[s/@\?\(\w\+\)\s*=\s*\(.*\)/let(:\1) { \2 }]])

require('nvim-surround').buffer_setup({
  surrounds = {
    ['#'] = {
      add = { '#{', '}' },
      find = '(#{)[^}]-(})',
      delete = '(#{)()[^}]-(})()',
    },
  },
})

vim.api.nvim_create_user_command('RSpec', function(cmd)
  local _, lnum, col = table.unpack(vim.fn.getcurpos())
  local file = cmd.args

  if file == '' then
    file = vim.fn.expand('%')
  end

  vim.g['test#last_position'] = {
    file = file,
    line = lnum,
    col = col,
  }

  vim.cmd.T(string.format('bundle exec rspec %s:%s:%s', file, lnum, col))
end, { nargs = '?' })

vim.cmd('cabbrev Rspec RSpec')
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
