local M = {}

M.tbl_remove = function(tbl, list)
  assert(type(tbl) == 'table', string.format('Expected table, got %s', type(tbl)))
  assert(type(list) == 'table', string.format('Expected table, got %s', type(list)))

  return hs.fnutils.filter(tbl, function(element)
    return not M.tbl_contains(list, element)
  end)
end

M.tbl_contains = function(tbl, given)
  assert(type(tbl) == 'table', string.format('Expected table, got %s', type(tbl)))

  return hs.fnutils.contains(tbl, given)
end

M.tbl_keys = function(tbl)
  assert(type(tbl) == 'table', string.format('Expected table, got %s', type(tbl)))

  local keys = {}
  for k, _ in pairs(tbl) do
    table.insert(keys, k)
  end

  return keys
end

return M
