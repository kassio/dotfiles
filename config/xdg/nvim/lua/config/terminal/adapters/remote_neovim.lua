local M = { name = 'remote_neovim' }

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

function M.start()
  vim.fn.serverstart(M.address)
  vim.g.terminal_server = true

  return require('config.terminal.adapters.native').execute({
    fn = 'nvim_cmd',
    opts = { string = 'only' },
  })
end

function M.can_execute()
  return vim.fn.filereadable(M.address) == 1
end

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
