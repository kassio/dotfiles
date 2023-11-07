local address = vim.fs.joinpath(vim.fn.stdpath('cache'), 'terminal_server.pipe')
local M = { name = 'remote_neovim' }

local function rpc(cmd)
  return string.format(
    [[<C-\><C-N>:lua require("config.terminal.manager").with_terminal(%s)<CR>]],
    vim.inspect(cmd, { newline = '', indent = '' })
  )
end

function M.start()
  vim.fn.serverstart(address)
  vim.g.terminal_server = true

  return require('config.terminal.adapters.native').execute({
    fn = 'nvim_cmd',
    opts = { string = 'only' },
  })
end

function M.can_execute(has_native)
  if has_native ~= nil then
    return false
  end

  return vim.fn.filereadable(address) == 1
end

function M.execute(cmd)
  vim.system({
    'nvim',
    '--server',
    address,
    '--remote-send',
    rpc(cmd),
  })
end

return M
