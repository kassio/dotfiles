local adapters = require('config.terminal.adapters')

local manager = { active = nil }

--- Choose the right adapter to run the given function and arguments
function manager.with_terminal(cmd)
  if
    vim.fn.filereadable(adapters.remote.addr) == 0 -- there's no terminal server running
    or vim.g.terminal_server == true -- this is the terminal server
    or manager.active ~= nil -- this neovim have a managed terminal
  then
    manager.active = adapters.native(manager.active, cmd)
  else
    adapters.remote(cmd)
  end
end

function manager.only()
  manager.with_terminal({ fn = 'only' })
end

function manager.toggle(opts)
  manager.with_terminal({ fn = 'toggle', args = { opts = opts } })
end

--- Send command to the terminal
---@param str string string/command to send
---@param skip_break_line boolean [optional] by default commands have a
---                               break line in the end, this option when set
---                               don't add the break line.
function manager.send(str, skip_break_line)
  manager.with_terminal({
    fn = 'send',
    args = {
      string = str,
      skip_break_line = skip_break_line,
    },
  })
end

function manager.server_start()
  vim.fn.serverstart(adapters.remote.addr)
  vim.g.terminal_server = true

  manager.active = adapters.native(nil, { fn = 'only' })
end

return manager
