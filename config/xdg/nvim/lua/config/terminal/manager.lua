local adapters = require('config.terminal.adapters')

local manager = {
  active = nil,
  server_addr = vim.fs.joinpath(vim.fn.stdpath('cache'), 'terminal_server.pipe'),
}

--- Choose the right adapter to run the given function and arguments
function manager.with_terminal(fn, args)
  if
    vim.fn.filereadable(manager.server_addr) == 0 -- there's no terminal server running
    or vim.g.terminal_server == true -- this is the terminal server
    or manager.active ~= nil -- this neovim have a managed terminal
  then
    manager.active = adapters.native[fn](manager.active, args)

    if type(args) == 'table' and args.after_run ~= nil then
      args.after_run(manager.active)
    end
  else
    adapters.remote[fn](manager.server_addr, args)
  end
end

function manager.toggle(opts)
  manager.with_terminal('toggle', opts)
end

function manager.only()
  manager.with_terminal('only')
end

function manager.kill()
  manager.with_terminal('kill')
end

function manager.send(str)
  manager.with_terminal('send', str)
end

function manager.server_start()
  manager.active = adapters.native.toggle()
  adapters.native.only(manager.active)

  vim.g.terminal_server = true
  vim.fn.serverstart(manager.server_addr)
end

return manager
