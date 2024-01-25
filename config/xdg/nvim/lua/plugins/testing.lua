return {
  'vim-test/vim-test',
  keys = {
    { '<leader>ta', '<cmd>TestSuite<cr>' },
    { '<leader>tf', '<cmd>TestFile<cr>' },
    { '<leader>tc', '<cmd>TestNearest<cr>' },
    { '<leader>tr', '<cmd>TestLast<cr>' },
  },
  cmd = {
    'TestSuite',
    'TestFile',
    'TestNearest',
    'TestLast',
    'TestCommand',
    'TestStrategy',
    'WeztermTest',
  },
  config = function()
    vim.g['test#custom_strategies'] = {
      terminal = function(cmd)
        vim.cmd.Tcmd(string.format('let g:test#last_strategy = "terminal"'))
        vim.cmd.Tcmd(string.format('let g:test#last_command = %q', cmd))
        vim.cmd.T(cmd)
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
