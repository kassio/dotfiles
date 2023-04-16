return {
  'vim-test/vim-test',
  keys = {
    { '<leader>ta', '<cmd>Tclear | TestSuite<cr>' },
    { '<leader>tf', '<cmd>Tclear | TestFile<cr>' },
    { '<leader>tc', '<cmd>Tclear | TestNearest<cr>' },
    { '<leader>tr', '<cmd>Tclear | TestLast<cr>' },
  },
  cmd = {
    'TestSuite',
    'TestFile',
    'TestNearest',
    'TestLast',
    'TestCommand',
  },
  config = function()
    vim.g['test#strategy'] = 'neoterm'
    vim.g['test#go#gotest#executable'] = 'GOFLAGS="-count=1" go test -v'

    vim.api.nvim_create_user_command('TestCommand', function(c)
      vim.g['test#last_strategy'] = 'neoterm'
      vim.g['test#last_command'] = table.concat({ 'clear', c.args }, ' && ')

      vim.cmd.TestLast()
    end, { nargs = '+' })
  end,
}
