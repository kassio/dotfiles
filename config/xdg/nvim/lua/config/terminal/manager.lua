local M = {
  active = nil,
  remote = require('config.terminal.adapters.remote'),
  native = require('config.terminal.adapters.native'),
}

---Choose the right adapter to run the given function and arguments
function M.with_terminal(cmd)
  if
    vim.fn.filereadable(M.remote.address) == 0 -- there's no terminal server running
    or vim.g.terminal_server == true -- this is the terminal server
    or M.active ~= nil -- this neovim have a managed terminal
  then
    cmd.termdata = M.active
    M.active = M.native.execute(cmd)
  else
    M.remote.execute(cmd)
  end
end

function M.toggle(opts)
  M.with_terminal({ fn = 'toggle', opts = opts or {} })
end

function M.cmd(str)
  M.with_terminal({ fn = 'cmd', opts = { string = str } })
end

---Send command to the terminal
---@param str string string/command to send, can be a vim.keycode
---@param breakline boolean|nil [default=true] send a breakline at the end of the given string
function M.send(str, breakline)
  if breakline == nil then
    breakline = true
  end

  M.with_terminal({
    fn = 'send',
    opts = {
      string = str,
      breakline = breakline,
    },
  })
end

function M.server_start()
  vim.fn.serverstart(M.remote.address)
  vim.g.terminal_server = true

  M.active = M.native.execute({ fn = 'cmd', opts = { string = 'only' } })
end

return M
