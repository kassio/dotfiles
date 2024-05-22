local M = {}

function M.def(group, color)
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

function M.extend(target, source, opts)
  M.def(target, vim.tbl_extend('force', M.get(source), opts or {}))
end

function M.get_sign_icon(name)
  local sign = vim.fn.sign_getdefined(name)[1]

  if sign == nil then
    return '', ''
  end

  return vim.trim(sign.text or ''), vim.trim(sign.texthl or '')
end

return M
