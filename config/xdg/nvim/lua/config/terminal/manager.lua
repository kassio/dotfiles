local adapters = require('config.terminal.adapters')

local manager = { active = nil }

--- Choose the right adapter to run the given function and arguments
function manager.with_terminal(args)
  if
    vim.fn.filereadable(adapters.remote.addr) == 0 -- there's no terminal server running
    or vim.g.terminal_server == true -- this is the terminal server
    or manager.active ~= nil -- this neovim have a managed terminal
  then
    manager.active = adapters.native(manager.active, args)
  else
    adapters.remote(args)
  end
end

function manager.toggle(opts)
  manager.with_terminal({ fn = 'toggle', args = opts })
end

function manager.only()
  manager.with_terminal({ fn = 'only' })
end

function manager.kill()
  manager.with_terminal({ fn = 'kill' })
end

function manager.send(str)
  manager.with_terminal({ fn = 'send', args = str })
end

function manager.server_start()
  vim.fn.serverstart(adapters.remote.addr)
  vim.g.terminal_server = true

  manager.active = adapters.native(nil, { fn = 'only' })
end

return manager
