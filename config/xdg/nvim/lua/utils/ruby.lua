local utils = require('utils')

local M = {}

function M.file_namespace()
  local prestart = false
  local start = false
  local path = ''
  local base = vim.fn.expand('%:p:r')

  for dir in vim.gsplit(base, '/', { plain = true, trimempty = true }) do
    if start == true then
      dir = vim.fn.fnamemodify(dir, ':t:r')
      path = path .. '::' .. utils.string.camelcase(dir)
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

function M.rubocop_code()
  local _, lnum, _ = utils.table.unpack(vim.fn.getcurpos())
  local all_diagnostics = vim.diagnostic.get(0, { lnum = lnum })

  if #all_diagnostics == 0 then
    return ''
  end

  local diagnostics = vim.tbl_filter(function(diagnostic)
    return diagnostic.source == 'rubocop'
  end, all_diagnostics)

  return vim.tbl_get(diagnostics, 1, 'code') or 'CodeReuse/ActiveRecord'
end

return M
