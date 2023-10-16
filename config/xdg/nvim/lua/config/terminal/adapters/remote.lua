local M = {}

local function build_address()
  local base = vim.fn.stdpath('cache')
  if type(base) == 'table' then
    base = base[1]
  end

  return vim.fs.joinpath(base, 'terminal_server.pipe')
end

local function rpc(cmd)
  return string.format(
    [[<C-\><C-N>:lua require("config.terminal.manager").with_terminal(%s)<CR>]],
    vim.inspect(cmd, { newline = '', indent = '' })
  )
end

M.address = build_address()

function M.execute(cmd)
  vim.system({
    'nvim',
    '--server',
    M.address,
    '--remote-send',
    rpc(cmd),
  })
end

return M
