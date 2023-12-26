local M = {
  active = nil,
  native = require('config.terminal.adapters.native'),
  remote_adapters = {
    require('config.terminal.adapters.remote_neovim'),
    require('config.terminal.adapters.wezterm'),
  },
}

---Choose the right adapter to run the given function and arguments
function M.with_terminal(cmd)
  vim.cmd('doautocmd User TermSend')

  for _, adapter in ipairs(M.remote_adapters) do
    if adapter.can_execute(M.active) then
      adapter.execute(cmd)
      return
    end
  end

  cmd.termdata = M.active
  M.active = M.native.execute(cmd)
end

function M.toggle(opts)
  M.with_terminal({ fn = 'toggle', opts = opts or {} })
end

function M.nvim_cmd(str)
  M.with_terminal({ fn = 'nvim_cmd', opts = { string = str } })
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

return M
