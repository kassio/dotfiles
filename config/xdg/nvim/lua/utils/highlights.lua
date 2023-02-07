local M = {}

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

M.def_sign = function(name, icon)
  vim.fn.sign_define(name, {
    text = icon,
    texthl = name,
  })
end

M.get_sign_icon = function(name)
  local sign = vim.fn.sign_getdefined(name)[1]

  return vim.trim(sign.text)
end

return M
