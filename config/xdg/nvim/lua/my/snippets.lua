local M = {}

M.filename = function(case, sufix)
  local filename = vim.api.nvim_buf_get_name(0)
  filename = vim.fn.fnamemodify(filename, ':t:r')

  if sufix ~= nil then
    filename = filename:gsub(sufix, '')
  end

  if case == 'camelcase' then
    return string.camelcase(filename)
  else
    return filename
  end
end

M.expand = function(fmt, default)
  local path = vim.fn.expand(fmt)

  if path == '.' then
    return default or path
  else
    return path
  end
end

return M
