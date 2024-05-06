local utils = require('utils')
local tsutils = require('plugins.treesitter.utils')
local ts = vim.treesitter

local M = {}

function M.fetch(opts)
  local ok, parser = pcall(ts.get_parser, 0)
  if not ok or not parser then
    return ''
  end

  local options = opts or {}
  if type(opts) == 'number' then
    options = { indicator_size = opts }
  end

  local indicator_size = options.indicator_size or 100
  local type_patterns = options.type_patterns or { 'class', 'function', 'method' }
  local transform_fn = options.transform_fn or tsutils.get_node_text
  local separator = options.separator or ' 〉'

  local current_node = ts.get_node()
  if not current_node then
    return ''
  end

  local node = current_node
  local parts = {}

  while node do
    local text = transform_fn(node)
    if text ~= '' then
      table.insert(parts, 1, text)
    end

    node = tsutils.ancestors_by_type(node, type_patterns)
  end

  local text = table.concat(utils.table.compact_list(parts), separator)
  local text_len = #text
  if text_len > indicator_size then
    return '...' .. text:sub(text_len - indicator_size, text_len)
  end

  return text
end

return M
