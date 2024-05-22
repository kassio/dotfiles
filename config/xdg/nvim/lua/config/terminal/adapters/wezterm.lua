local M = {}

local function send(value)
  vim.system({ 'wts', vim.g.wezterm_pane_id, value }):wait()
end

function M.send(opts)
  send(opts.string)
end

local adapter = { name = 'wezterm' }

function adapter.list_panes()
  local result = vim
    .system({ 'wezterm', 'cli', 'list', '--format', 'json' }, {
      text = true,
    })
    :wait()

  return vim.fn.json_decode(result.stdout)
end

function adapter.start(id)
  id = tonumber(id) or -1

  if id < 0 then
    vim.notify('Desconnecting with wezterm pane id: ' .. vim.g.wezterm_pane_id)
    vim.g.wezterm_pane_id = nil
  else
    vim.notify('Connecting with wezterm pane id: ' .. id)
    vim.g.wezterm_pane_id = id
  end
end

function adapter.can_execute(has_native)
  if has_native ~= nil then
    return false
  end

  return vim.g.wezterm_pane_id ~= nil or not vim.fn.empty(vim.g.wezterm_pane_id)
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
