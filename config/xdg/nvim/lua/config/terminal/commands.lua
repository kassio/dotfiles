local wezterm = require('config.terminal.adapters.wezterm')

local function command(name, callback, opts)
  opts = opts or {}
  if opts.desc then
    opts.desc = 'terminal: ' .. opts.desc
  end

  vim.api.nvim_create_user_command(name, callback, opts)
end

return {
  setup = function(manager)
    command('TerminalServerStart', function()
      manager.active = require('config.terminal.adapters.remote_neovim').start()
      vim.opt.laststatus = 0
      vim.opt.showtabline = 0
      vim.opt.winbar = ''
    end, { desc = 'start remote terminal server' })

    command('TerminalWeztermPane', function(opts)
      local pane_id = string.match(opts.args, '(%d+) - .*')
      if not pane_id and string.find(opts.args, '%d+') then
        pane_id = opts.args
      end

      wezterm.start(pane_id)
    end, {
      nargs = 1,
      desc = 'define which wezterm pane use as terminal target',
      complete = function()
        return vim
          .iter(wezterm.list_panes())
          :map(function(item)
            return string.format('%s - %s', item.pane_id, item.title)
          end)
          :totable()
      end,
    })

    command('TerminalWeztermDisconnect', wezterm.disconnect, {
      desc = 'desconnect from wezterm as a terminal target',
    })

    command('T', function(opts)
      manager.send(vim.fn.expandcmd(opts.args))
    end, { nargs = '+', desc = 'send the argument as a terminal command' })

    -- run nvim command
    command('Tnvim', function(opts)
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
  end,
}
