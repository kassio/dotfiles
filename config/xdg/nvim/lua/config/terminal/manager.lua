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

function M.set_prefix(str)
  vim.g.terminal_command_prefix = str
end

function M.set_suffix(str)
  vim.g.terminal_command_suffix = str
end

---Send command to the terminal
--- @param str string string/command to send, can be a vim.keycode
--- @param opts table Options with the following fields
---  - breakline (boolean): send a breakline at the end of the given string (default true)
---  - include_prefix (boolean): if the global prefix is included (default true)
---  - include_suffix (boolean): if the global suffix is included (default true)
function M.send(str, opts)
  opts = vim.tbl_extend('keep', opts or {}, {
    breakline = true,
    include_prefix = true,
    include_suffix = true,
  })

  if opts.breakline == nil then
    opts.breakline = true
  end

  local command_prefix = ''
  local command_suffix = ''
  if opts.include_prefix then
    command_prefix = vim.g.terminal_command_prefix or ''
  end
  if opts.include_suffix then
    command_suffix = vim.g.terminal_command_suffix or ''
  end

  local command = vim.trim(string.format(
    '%s %s %s',
    command_prefix,
    str,
    command_suffix
  ))

  M.with_terminal({
    fn = 'send',
    opts = {
      string = command,
      breakline = opts.breakline,
    },
  })
end

return M
