local M = {}

local function cmd(fn, args)
  local cmdstr = string.format([[require("config.terminal.manager").with_terminal('%s']], fn)
  if args == nil then
    cmdstr = cmdstr .. ')'
  else
    cmdstr = cmdstr .. string.format(", '%s')", args)
  end

  return string.format([[<C-\><C-N>:lua %s<CR>]], cmdstr)
end

local function with_terminal(addr, fn, args)
  vim.system({
    'nvim',
    '--server',
    addr,
    '--remote-send',
    cmd(fn, args),
  })
end

function M.toggle(addr)
  M.only(addr)
end

function M.only(addr)
  with_terminal(addr, 'only')
end

function M.send(addr, str)
  with_terminal(addr, 'send', str)
end

function M.keycode(addr, str)
  with_terminal(addr, 'keycode', str)
end

return M
