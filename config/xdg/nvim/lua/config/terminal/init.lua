return {
  setup = function()
    local manager = require('config.terminal.manager')

    require('config.terminal.autocmds').setup(manager)

    vim.api.nvim_create_user_command('TerminalServerStart', function()
      vim.g.terminal_server = true
      vim.fn.serverstart(manager.server.addr)
      manager.new({
        after_open = function(termdata)
          vim.cmd.only()
        end,
      })
    end, {})

    vim.api.nvim_create_user_command('Tdebug', function(opts)
      vim.print(manager)
    end, {})

    vim.api.nvim_create_user_command('T', function(opts)
      manager.send(opts.args)
    end, { nargs = '+' })

    vim.api.nvim_create_user_command('Tcd', function(opts)
      local pwd = vim.fn.getcwd()
      if #opts.args > 0 then
        pwd = opts.args
      end

      manager.send('cd ' .. pwd)
    end, { nargs = '?' })

    vim.keymap.set('n', '<leader>tt', function()
      manager.toggle()
    end)

    vim.keymap.set('n', '<leader>th', function()
      manager.toggle({ position = 'horizontal', mod = 'botright' })
    end)

    vim.keymap.set('n', '<leader>tv', function()
      manager.toggle({ position = 'vertical' })
    end)

    vim.keymap.set('n', '<leader>te', function()
      manager.send('exit')
    end)

    vim.keymap.set('n', '<leader>tl', function()
      manager.send('clear')
    end)

    vim.keymap.set('n', '<leader>tk', function()
      manager.keycode('<c-c>')
    end)
  end,
}
