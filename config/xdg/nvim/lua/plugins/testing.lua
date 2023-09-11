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
        vim.env.XDG_CACHE_HOME .. '/nvim/terminal_server.pipe',
        '--remote-send',
        string.format([[<C-\><C-N>:Tclear | T %s<CR>]], c),
      }

      vim.system(cmd, { text = true }, function(obj)
        local notify = function(msg)
          vim.notify(msg, vim.log.levels.INFO, { title = 'vim-test' })
        end

        if #obj.stdout > 0 then
          notify(obj.stdout)
        end

        if #obj.stderr > 0 then
          notify(obj.stderr)
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
      vim.g['test#last_strategy'] = 'neoterm'
      vim.g['test#last_command'] = c.args

      vim.cmd.TestLast()
    end, { nargs = '+' })

    vim.api.nvim_create_user_command('TestStrategy', function(c)
      local strategy = c.args
      if strategy == 'terminal_server' then
        vim.g['test#strategy'] = strategy
        terminal_server('cd ' .. vim.fn.getcwd(0))
        terminal_server('clear')
      elseif strategy == 'neoterm' then
        vim.g['test#strategy'] = strategy
      else
        vim.notify('Unknown strategy: ' .. strategy, vim.log.levels.ERROR)
      end
    end, {
      nargs = '+',
      complete = function()
        return { 'neoterm', 'terminal_server' }
      end,
    })
  end,
}
