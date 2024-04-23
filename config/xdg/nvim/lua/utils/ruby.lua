local utils = require('utils')

local M = {}

function M.file_namespace(kind)
  local prestart = false
  local start = false
  local base = vim.fn.expand('%:p:r')

  local dirs = {}
  for dir in vim.gsplit(base, '/', { plain = true, trimempty = true }) do
    if start == true then
      dir = vim.fn.fnamemodify(dir, ':t:r')
      dir = utils.string.camelcase(dir)
      table.insert(dirs, dir)
    elseif dir == 'lib' then
      start = true
    elseif dir == 'app' then -- on rails we don't use models/controllers/etc on namespace
      prestart = true
    elseif prestart == true then
      start = true
    end
  end

  vim.print(dirs)

  local namespace = ''
  for i, dir in ipairs(dirs) do
    local indent = string.rep(' ', (i - 1) * 2)
    if i == 1 and #dirs ~= 1 then
      namespace = string.format('module %s', dir)
    elseif i == #dirs then
      namespace = string.format('%s\n%s%s %s', namespace, indent, kind, dir)
    else
      namespace = string.format('%s\n%smodule %s', namespace, indent, dir)
    end
  end

  return vim.trim(namespace)
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
