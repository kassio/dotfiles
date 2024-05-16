return {
  'vim-test/vim-test',
  keys = {
    { '<leader>ta', vim.cmd.TestSuite },
    { '<leader>tf', vim.cmd.TestFile },
    { '<leader>tc', vim.cmd.TestNearest },
    { '<leader>tr', vim.cmd.TestLast },
  },
  cmd = {
    'TestSuite',
    'TestFile',
    'TestNearest',
    'TestLast',
    'TestCommand',
    'TestStrategy',
  },
  config = function()
    vim.g['test#custom_strategies'] = {
      terminal = function(cmd)
        vim.cmd(string.format('silent! Tcmd let g:test#last_strategy = "terminal"'))
        vim.cmd(string.format('silent! Tcmd let g:test#last_command = %q', cmd))
        vim.cmd(string.format('silent! T %s', cmd))
      end,
    }

    vim.g['test#strategy'] = 'terminal'

    vim.api.nvim_create_user_command('TestCommand', function(c)
      vim.g['test#last_strategy'] = vim.g['test#strategy']
      vim.g['test#last_command'] = c.args

      vim.cmd.TestLast()
    end, { nargs = '+' })
  end,
}
