local M = {}

function M.send(opts)
  vim.system({ 'wts', vim.g.wezterm, opts.string }):wait()
end

local adapter = { name = 'wezterm' }

function adapter.start(args)
  vim.g.wezterm = args
end

function adapter.can_execute()
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
