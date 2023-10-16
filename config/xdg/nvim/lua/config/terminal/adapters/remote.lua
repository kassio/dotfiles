local M = { addr = vim.fs.joinpath(vim.fn.stdpath('cache'), 'terminal_server.pipe') }

local function rpc(cmd)
  return string.format(
    [[<C-\><C-N>:lua require("config.terminal.manager").with_terminal(%s)<CR>]],
    vim.inspect(cmd, { newline = '', indent = '' })
  )
end

function M.execute(remote, cmd)
  vim.system({
    'nvim',
    '--server',
    remote.addr,
    '--remote-send',
    rpc(cmd),
  })
end

return M
