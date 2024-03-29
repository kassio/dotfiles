local M = {}

local function send(value)
  vim.system({ 'wts', vim.g.wezterm, value }):wait()
end

function M.send(opts)
  send(opts.string)
end

local adapter = { name = 'wezterm' }

function adapter.start(id)
  id = tonumber(id) or 0

  if id <= 0 then
    vim.g.wezterm = nil
  else
    vim.g.wezterm = id
  end
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
