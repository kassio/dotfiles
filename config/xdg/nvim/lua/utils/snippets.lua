local utils = require('utils')

local M = {}

M.filename = function(case, sufix)
  local filename = vim.api.nvim_buf_get_name(0)
  filename = vim.fn.fnamemodify(filename, ':t:r')

  if sufix ~= nil then
    filename = filename:gsub(sufix, '')
  end

  if case == 'camelcase' then
    return utils.string.camelcase(filename)
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

M.ruby_class = function()
  local filename = vim.fn.expand('%:.')

  if string.match(filename, '^lib/') or string.match(filename, '^app/') then
    local result = ''

    for dir in string.gmatch(filename, '(%w+)/') do
      if dir ~= 'lib' and dir ~= 'app' then
        result = result .. '::' .. utils.string.camelcase(dir)
      end
    end

    return result .. '::' .. M.filename('camelcase')
  else
    return M.filename('camelcase')
  end
end

return M
