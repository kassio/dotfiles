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
  },
  config = function()
    local terminal_server = function(c)
      local cmd = {
        'nvim',
        '--server',
        vim.env.NVIM_TERMINAL_SERVER_PIPE,
        '--remote-send',
        string.format([[<C-\><C-N>:Tclear | T %s<CR>]], c),
      }

      vim.system(cmd, { text = true }, function(obj)
        if obj.code == 0 and obj.signal == 0 then
          vim.notify(c, vim.log.levels.INFO, { title = 'Testing: Succeed' })
        else
          vim.notify(c, vim.log.levels.ERROR, { title = 'Testing: Failed' })
        end
      end)
    end

    vim.g['test#custom_strategies'] = {
      terminal_server = terminal_server,
      neoterm = function(cmd)
        vim.cmd('Tclear | T ' .. cmd)
      end,
    }

    vim.g['test#strategy'] = 'neoterm'
    vim.g['test#go#gotest#executable'] = 'GOFLAGS="-count=1" go test -v'

    vim.api.nvim_create_user_command('TestCommand', function(c)
      vim.g['test#last_strategy'] = vim.g['test#strategy']
      vim.g['test#last_command'] = c.args

      vim.cmd.TestLast()
    end, { nargs = '+' })

    vim.api.nvim_create_user_command('TestStrategy', function(c)
      local strategy = c.args

      if strategy == 'terminal_server' then
        if vim.fn.filereadable(vim.env.NVIM_TERMINAL_SERVER_PIPE) == 0 then
          vim.notify('Server not running!', vim.log.levels.WARN, { title = 'Testing' })
        else
          vim.g['test#strategy'] = strategy
          terminal_server('cd ' .. vim.fn.getcwd(0))
          terminal_server('clear')
        end
      elseif strategy == 'neoterm' then
        vim.g['test#strategy'] = strategy
      else
        vim.notify('Unknown strategy: ' .. strategy, vim.log.levels.ERROR, { title = 'Testing' })
      end
    end, {
      nargs = '+',
      complete = function()
        return { 'neoterm', 'terminal_server' }
      end,
    })
  end,
}
