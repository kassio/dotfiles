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

  if #dirs == 0 then
    local namespace, _ = utils.string.camelcase(vim.fn.expand('%:t:r'))
    return string.format('%s %s', kind, namespace)
  end

  local headers = vim
    .iter(ipairs(dirs))
    :map(function(i, dir)
      local indent = string.rep(' ', (i - 1) * 2)
      if i == 1 and #dirs ~= 1 then
        return string.format('module %s', dir)
      elseif i == #dirs then
        return string.format('%s%s %s', indent, kind, dir)
      else
        return string.format('%smodule %s', indent, dir)
      end
    end)
    :totable()

  local tails = vim
    .iter(ipairs(headers))
    :map(function(i, _)
      local indent = string.rep(' ', (i - 1) * 2)
      return string.format('%send', indent)
    end)
    :totable()

  return string.format(
    '%s\n\n%s',
    table.concat(headers, '\n'),
    table.concat(vim.fn.reverse(tails), '\n')
  )
end

function M.treesitter_namespace()
  if vim.bo.filetype ~= 'ruby' then
    return ''
  end

  return require('plugins.treesitter.fetcher').fetch()
end

local function get_rubocop_codes(lnum)
  return vim
    .iter(vim.diagnostic.get(0, { lnum = lnum }))
    :filter(function(diagnostic)
      return string.lower(diagnostic.source) == 'rubocop'
    end)
    :map(function(diagnostic)
      return diagnostic.code
    end)
end

function M.rubocop_code()
  return '# rubocop: disable ' .. get_rubocop_codes(vim.fn.line('.') - 1):pop()
end

function M.rubocop_codes()
  return get_rubocop_codes(vim.fn.line('.'))
    :map(function(code)
      return '# rubocop: disable ' .. code
    end)
    :join('\n')
end

return M
