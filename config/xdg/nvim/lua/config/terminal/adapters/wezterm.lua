local M = { name = 'wezterm' }

function M.list_panes()
  local result = vim
    .system({ 'wezterm', 'cli', 'list', '--format', 'json' }, {
      text = true,
    })
    :wait()

  return vim.fn.json_decode(result.stdout)
end

function M.disconnect()
  vim.notify('Desconnecting from wezterm')
  vim.g.wezterm_pane_id = nil
end

function M.start(id)
  id = tonumber(id)

  vim.notify('Connecting with wezterm pane id: ' .. id)
  vim.g.wezterm_pane_id = id
end

function M.can_execute(has_native)
  if has_native ~= nil then
    return false
  end

  return vim.g.wezterm_pane_id ~= nil or not vim.fn.empty(vim.g.wezterm_pane_id)
end

function M.execute(cmd)
  if cmd.fn ~= 'send' then
    vim.print(string.format('[%s] %s not supported', M.name, cmd.fn))
    return
  end

  vim.system({ 'wts', vim.g.wezterm_pane_id, cmd.opts.string }):wait()
end

return M
