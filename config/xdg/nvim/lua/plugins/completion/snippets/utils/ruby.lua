local utils = require('utils')

local M = {}

local function file_structure()
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

  if #dirs == 0 then
    local namespace, _ = utils.string.camelcase(vim.fn.expand('%:t:r'))

    table.insert(dirs, namespace)
  end

  return dirs
end

function M.type_inline()
  return '::' .. table.concat(file_structure(), '::')
end

function M.type_block(kind)
  local dirs = file_structure()

  -- Adds the {body} after the full type
  table.insert(dirs, '{body}')

  local headers = vim
    .iter(ipairs(dirs))
    :map(function(i, dir)
      local indent = string.rep(' ', (i - 1) * 2)

      if i == 1 and #dirs ~= 1 then -- namespace
        return string.format('module %s', dir)
      elseif i == #dirs - 1 then -- current type
        return string.format('%s%s %s {inheritance}', indent, kind, dir)
      elseif i == #dirs then -- body
        return string.format('%s%s', indent, dir)
      else -- namespace
        return string.format('%smodule %s', indent, dir)
      end
    end)
    :totable()

  -- remove the extra "end" added with the "{body}"
  table.remove(dirs)

  local tails = vim
    .iter(ipairs(dirs))
    :map(function(i, _)
      local indent = string.rep(' ', (i - 1) * 2)
      return string.format('%send', indent)
    end)
    :totable()


  return string.format(vim.trim([[
      %s
      %s
    ]]),
    table.concat(headers, '\n'),
    table.concat(vim.fn.reverse(tails), '\n'))
end

return M
