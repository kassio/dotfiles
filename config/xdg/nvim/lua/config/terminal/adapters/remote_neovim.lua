local address = vim.fs.joinpath(vim.fn.stdpath('cache'), 'terminal_server.pipe')
local M = { name = 'remote_neovim' }

local function remote_send(cmd)
  vim.system({
    'nvim',
    '--server',
    address,
    '--remote-send',
    cmd,
  })
end

local function with_terminal(cmd)
  return string.format(
    [[<C-\><C-N>:lua require("config.terminal.manager").with_terminal(%s)<CR>]],
    vim.inspect(cmd, { newline = '', indent = '' })
  )
end

local function server_start()
  local ok = pcall(vim.fn.serverstart, address)
  if not ok then
    local answer =
      vim.fn.confirm('Server already running, force restart?', '&Yes\n&No', vim.v.t_number)
    if answer == 1 then
      os.remove(address)
      vim.fn.serverstart(address)
    else
      vim.cmd.qall()
    end
  end
end

function M.start()
  server_start()

  vim.g.terminal_server = true

  return require('config.terminal.adapters.native').execute({
    fn = 'nvim_cmd',
    opts = { string = 'only' },
  })
end

function M.can_execute(has_native)
  -- if current nvim instance is the server, it cannot execute a remote terminal
  if has_native ~= nil or vim.g.terminal_server == true then
    return false
  end

  return vim.fn.filereadable(address) == 1
end

function M.execute(cmd)
  remote_send(with_terminal(cmd))
end

return M
