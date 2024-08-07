local utils = require('utils')
local tsutils = require('plugins.treesitter.utils')
local ts = vim.treesitter

local default_options = {
  enabled = true,
  indicator_size = 100,
  type_patterns = { 'class', 'function', 'method' },
  transform_fn = tsutils.get_node_text,
  separator = ' 〉',
}

local filetype_options = setmetatable({}, {
  __index = function(tbl, ft)
    local ok, opts = pcall(require, 'plugins.treesitter.fetcher.' .. ft)
    local result

    if ok then
      result = vim.tbl_deep_extend('keep', opts, default_options)
    else
      result = default_options
    end

    tbl[ft] = result
    return result
  end,
})

local M = {}

function M.fetch()
  local opts = filetype_options[vim.bo.filetype]
  if opts.enabled == false then
    return ''
  end

  local ok, parser = pcall(ts.get_parser, 0)
  if not ok or not parser then
    return ''
  end

  local current_node = ts.get_node()
  if not current_node then
    return ''
  end

  local node = current_node
  local parts = {}

  while node do
    local text = opts.transform_fn(node)
    if text ~= '' then
      table.insert(parts, 1, text)
    end

    node = tsutils.ancestors_by_type(node, opts.type_patterns)
  end

  local text = table.concat(utils.table.compact_list(parts), opts.separator)
  local text_len = #text
  if text_len > opts.indicator_size then
    return '...' .. text:sub(text_len - opts.indicator_size, text_len)
  end

  return text
end

return M
