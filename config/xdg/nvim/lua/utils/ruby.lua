local camelcase = require('utils.string').camelcase

local M = {}

function M.file_namespace()
  local prestart = false
  local start = false
  local path = ''
  local base = vim.fn.expand('%:p:r')

  for dir in vim.gsplit(base, '/', { plain = true, trimempty = true }) do
    if start == true then
      dir = vim.fn.fnamemodify(dir, ':t:r')
      path = path .. '::' .. camelcase(dir)
    elseif dir == 'lib' then
      start = true
    elseif dir == 'app' then -- on rails we don't use models/controllers/etc on namespace
      prestart = true
    elseif prestart == true then
      start = true
    end
  end

  return path
end

return M
