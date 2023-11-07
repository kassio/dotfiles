return {
  setup = function()
    local manager = require('config.terminal.manager')

    require('config.terminal.autocmds').setup(manager)

    vim.api.nvim_create_user_command('TerminalServerStart', function()
      manager.active = require('config.terminal.adapters.remote_neovim').start()
    end, {})

    vim.api.nvim_create_user_command('TerminalWeztermPane', function(opts)
      require('config.terminal.adapters.wezterm').start(opts.args)
    end, { nargs = 1 })

    vim.api.nvim_create_user_command('T', function(opts)
      manager.send(opts.args)
    end, { nargs = '+' })

    vim.api.nvim_create_user_command('TDEBUG', function()
      vim.print(manager)
    end, {})

    -- run nvim command
    vim.api.nvim_create_user_command('Tcmd', function(opts)
      manager.nvim_cmd(opts.args)
    end, { nargs = '+' })

    -- Navigate terminal to the given path of current path of current buffer
    vim.api.nvim_create_user_command('Tcd', function(opts)
      local pwd = vim.fn.getcwd()
      if #opts.args > 0 then
        pwd = opts.args
      end

      manager.send('cd ' .. pwd)
    end, { nargs = '?' })

    -- Set terminal as only buffer
    vim.keymap.set('n', '<leader>to', function()
      manager.nvim_cmd('only')
    end)

    vim.keymap.set('n', '<leader>tt', manager.toggle)

    vim.keymap.set('n', '<leader>th', function()
      manager.toggle({ position = 'horizontal' })
    end)

    vim.keymap.set('n', '<leader>tv', function()
      manager.toggle({ position = 'vertical' })
    end)

    vim.keymap.set('n', '<leader>tk', function()
      manager.send(vim.keycode('<c-c>'), false)
    end)

    vim.keymap.set('n', '<leader>te', function()
      manager.send('exit')
    end)

    vim.keymap.set('n', '<leader>tl', function()
      manager.send('clear')
    end)

    vim.keymap.set('n', '<leader>tL', function()
      manager.send('clear')

      pcall(function()
        local original = vim.bo[manager.active.bufnr].scrollback
        vim.bo[manager.active.bufnr].scrollback = 1
        vim.bo[manager.active.bufnr].scrollback = original
      end)
    end)
  end,
}
