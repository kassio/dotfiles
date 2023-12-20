local fn = vim.fn
local camelcase = require('utils.string').camelcase

local M = {}

function M.filename(opts)
  opts = opts or {}

  local filename = vim.api.nvim_buf_get_name(0)
  filename = fn.fnamemodify(filename, ':t:r')

  if opts.filter ~= nil then
    filename = string.gsub(filename, opts.filter, '')
  end

  if opts.case == 'camelcase' then
    filename = camelcase(filename)
  end

  return filename
end

function M.expand(fmt, default)
  local path = fn.expand(fmt)

  if path == '.' then
    return default or path
  else
    return path
  end
end

return M
