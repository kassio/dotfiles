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
    local log = require('utils').logger('testing')
    local neoterm_server_addr = vim.fs.joinpath(vim.fn.stdpath('cache'), 'neoterm_server.pipe')

    local neoterm_server = function(c)
      local cmd = {
        'nvim',
        '--server',
        neoterm_server_addr,
        '--remote-send',
        string.format([[<C-\><C-N>:Tclear | T %s<CR>]], c),
      }

      vim.system(cmd, { text = true }, function(obj)
        if obj.code == 0 and obj.signal == 0 then
          log.info(c, 'succeed')
        else
          log.error(c, 'failed')
        end
      end)
    end

    vim.g['test#custom_strategies'] = {
      neoterm_server = neoterm_server,
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

      if strategy == 'neoterm_server' then
        if vim.fn.filereadable(neoterm_server_addr) == 0 then
          log.warn('open another neovim and run :NeotermServerStart', 'server not running!')
        else
          vim.g['test#strategy'] = strategy
          neoterm_server('cd ' .. vim.fn.getcwd(0))
          neoterm_server('clear')
        end
      elseif strategy == 'neoterm' then
        vim.g['test#strategy'] = strategy
      else
        log.error('unknown strategy: ' .. strategy)
      end
    end, {
      nargs = '+',
      complete = function()
        return { 'neoterm', 'neoterm_server' }
      end,
    })
  end,
}
