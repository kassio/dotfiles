local M = {}

local function send(value)
  vim.system({ 'wts', vim.g.wezterm, value }):wait()
end

function M.send(opts)
  send(vim.keycode('<c-f7>'))
  send(opts.string)
  send(vim.keycode('<c-f7>'))
end

local adapter = { name = 'wezterm' }

function adapter.start(args)
  vim.g.wezterm = args
end

function adapter.can_execute(has_native)
  if has_native ~= nil then
    return false
  end
  return vim.g.wezterm ~= nil or not vim.fn.empty(vim.g.wezterm)
end

function adapter.execute(cmd)
  local fn = M[cmd.fn]
  if fn == nil then
    vim.print(string.format('[%s] %s not supported', adapter.name, cmd.fn))
    return
  end

  fn(cmd.opts)
end

return adapter
