local M = {}

M.sign = function(name, sign, highlight)
  vim.fn.sign_define(name, {
    text = sign,
    texthl = highlight or name,
  })
end

M.get = function(name)
  local ok, data = pcall(vim.api.nvim_get_hl_by_name, name, true)

  if not ok then
    local msg = string.format('Failed to find highlight by name "%s"', name)
    vim.notify(msg, vim.log.levels.ERROR)

    return {}
  end

  return data
end

M.def = function(group, color)
  local ok, msg = pcall(vim.api.nvim_set_hl, 0, group, color)

  if not ok then
    vim.notify(
      string.format(
        'Failed to set highlight (%s): group %s | color: %s',
        msg,
        group,
        vim.inspect(color)
      ),
      vim.log.levels.ERROR
    )
  end
end

M.extend = function(target, source, opts)
  M.def(target, vim.tbl_extend('force', M.get(source), opts or {}))
end

return M
