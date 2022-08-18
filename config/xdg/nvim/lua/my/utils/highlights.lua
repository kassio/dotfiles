local M = {}

M.sign = function(name, sign, highlight)
  vim.fn.sign_define(name, { text = sign, texthl = highlight or name })
end

M.get = function(name, extra)
  extra = extra or {}

  local ok, data = pcall(vim.api.nvim_get_hl_by_name, name, true)
  if not ok then
    return false, string.format('Failed to find highlight by name "%s"', name)
  end

  return true, vim.tbl_extend('force', data, extra)
end

M.def = function(group, color)
  local ok, msg = pcall(vim.api.nvim_set_hl, 0, group, color)

  if not ok then
    P(
      string.format(
        'Failed to set highlight (%s): group %s | color: %s',
        msg,
        group,
        vim.inspect(color)
      )
    )
  end
end

M.extend = function(target, source, opts)
  local ok, source_hl = M.get(source, opts or {})

  if ok then
    M.def(target, source_hl)
  else
    P(string.format('Failed to extend %s with %s: %s', target, source, vim.inspect(source_hl)))
    M.def(target, opts or {})
  end
end

return M
