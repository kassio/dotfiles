local ls = require('luasnip')
local fmt = require('luasnip.extras.fmt').fmt
local utils = require('utils')
local snippet_utils = require('plugins.completion.snippets.utils')

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

function M.type_inline(prefix, suffix)
  prefix = prefix or ''
  suffix = suffix or ''

  return ls.f(function()
    return prefix .. table.concat(file_structure(), '::') .. suffix
  end)
end

function M.type_block(kind)
  local dirs = file_structure()
  local max_indent = ''

  local headers = vim
    .iter(ipairs(dirs))
    :map(function(i, dir)
      max_indent = string.rep(' ', (i - 1) * 2)

      if i == 1 and #dirs ~= 1 then -- namespace
        return string.format('module %s', dir)
      elseif i == #dirs then -- current type
        return string.format('%s%s %s', max_indent, kind, dir)
      else -- namespace
        return string.format('%smodule %s', max_indent, dir)
      end
    end)
    :totable()

  local tails = vim
    .iter(ipairs(dirs))
    :map(function(i, _)
      local indent = string.rep(' ', (i - 1) * 2)
      return string.format('%send', indent)
    end)
    :totable()

  local text = table.concat({
    table.concat(headers, '\n'),
    '\n',
    max_indent .. '  {body}{cursor}',
    '\n',
    table.concat(vim.fn.reverse(tails), '\n'),
  })

  return fmt(text, {
    body = snippet_utils.selected_text(),
    cursor = ls.insert_node(0),
  })
end

return M
