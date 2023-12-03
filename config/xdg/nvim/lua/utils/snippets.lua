local fn = vim.fn
local S = require('utils.string')

local M = {}

function M.filename(opts)
  opts = opts or {}

  local filename = vim.api.nvim_buf_get_name(0)
  filename = fn.fnamemodify(filename, ':t:r')

  if opts.filter ~= nil then
    filename = string.gsub(filename, opts.filter, '')
  end

  if opts.case == 'camelcase' then
    filename = S.camelcase(filename)
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

function M.ruby_class()
  local filename = fn.expand('%:.')

  if string.match(filename, '^lib/') or string.match(filename, '^app/') then
    local result = ''

    for dir in string.gmatch(filename, '(%w+)/') do
      if dir ~= 'lib' and dir ~= 'app' then
        result = result .. '::' .. S.camelcase(dir)
      end
    end

    return result .. '::' .. M.filename('camelcase')
  else
    return M.filename('camelcase')
  end
end

return M
