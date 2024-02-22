local function command(name, callback, opts)
  vim.api.nvim_create_user_command(
    name,
    callback,
    vim.tbl_deep_extend('force', opts, {
      desc = 'terminal: ' .. opts.desc,
    })
  )
end

return {
  setup = function()
    local manager = require('config.terminal.manager')

    require('config.terminal.autocmds').setup(manager)

    command('TerminalServerStart', function()
      manager.active = require('config.terminal.adapters.remote_neovim').start()
    end, { desc = 'start remote terminal server' })

    command('TerminalWeztermPane', function(opts)
      require('config.terminal.adapters.wezterm').start(opts.args)
    end, { nargs = 1, desc = 'define which wezterm pane use as terminal target' })

    command('T', function(opts)
      manager.send(opts.args)
    end, { nargs = '+', desc = 'send the argument as a terminal command' })

    -- run nvim command
    command('Tcmd', function(opts)
      manager.nvim_cmd(opts.args)
    end, { nargs = '+', desc = 'execute a nvim command' })

    command('TDEBUG', function()
      vim.print(manager)
    end, { desc = 'print current terminal manager information' })

    command('Tmap', function(opts)
      manager.mapped_command = string.gsub(opts.args, '%%', vim.fn.expand('%:.'))
      manager.send(manager.mapped_command)
    end, { nargs = '+', desc = 'map the given command to be executed with <leader>tm' })

    command('Tmapexec', function()
      if manager.mapped_command ~= nil then
        manager.send(manager.mapped_command)
      end
    end, { desc = 'execute the mapped command with Tmap' })

    -- run last terminal command
    command('Tredo', function()
      manager.send('!!' .. vim.keycode('<cr>'))
    end, { desc = 'runs last terminal command (!!)' })

    -- Navigate terminal to the given path of current path of current buffer
    command('Tcd', function(opts)
      local pwd = vim.fn.getcwd()
      if #opts.args > 0 then
        pwd = opts.args
      end

      manager.send('cd ' .. pwd)
    end, { nargs = '?', desc = 'changes terminal path (defaults to current pwd)' })

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

    -- send ctrl+c (kill)
    vim.keymap.set('n', '<leader>tk', function()
      manager.send(vim.keycode('<c-c>'), false)
    end)

    vim.keymap.set('n', '<leader>te', function()
      manager.send('exit')
    end)

    vim.keymap.set('n', '<leader>tl', function()
      manager.send('clear')
    end)

    vim.keymap.set('n', '<leader>tg', function()
      manager.nvim_cmd('normal gg')
    end)

    vim.keymap.set('n', '<leader>tG', function()
      manager.nvim_cmd('normal G')
    end)

    vim.keymap.set('n', '<leader>tm', '<cmd>Tmapexec<cr>')

    vim.keymap.set('n', '<leader>tL', function()
      manager.send('clear-screen')

      -- redraw current window to avoid any weird state
      vim.cmd.mode()

      pcall(function()
        local original = vim.bo[manager.active.bufnr].scrollback
        vim.bo[manager.active.bufnr].scrollback = 1
        vim.bo[manager.active.bufnr].scrollback = original
      end)
    end)
  end,
}
