local adapters = require('config.terminal.adapters')

local manager = { active = nil }

---Choose the right adapter to run the given function and arguments
function manager.with_terminal(cmd)
  if
    vim.fn.filereadable(adapters.remote.addr) == 0 -- there's no terminal server running
    or vim.g.terminal_server == true -- this is the terminal server
    or manager.active ~= nil -- this neovim have a managed terminal
  then
    manager.active = adapters.native.execute(manager.active, cmd)
  else
    adapters.remote.execute(cmd)
  end
end

function manager.only()
  manager.with_terminal({ fn = 'only' })
end

function manager.toggle(opts)
  manager.with_terminal({ fn = 'toggle', opts = opts or {} })
end

---Send command to the terminal
---@param str string string/command to send, can be a vim.keycode
---@param breakline boolean [default=true] send a breakline at the end of the given string
function manager.send(str, breakline)
  if breakline == nil then
    breakline = true
  end

  manager.with_terminal({
    fn = 'send',
    opts = {
      string = str,
      breakline = breakline,
    },
  })
end

function manager.server_start()
  vim.fn.serverstart(adapters.remote.addr)
  vim.g.terminal_server = true

  manager.active = adapters.native.only()
end

return manager
