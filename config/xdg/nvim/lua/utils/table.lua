local M = {}

if not table.unpack then
  M.unpack = unpack
end

if not M.pack then
  function M.pack(...)
    return { ... }
  end
end

--- Removes the given key from the table, returning its value.
---@param tbl table
---@param key any
---@return any
function M.removekey(tbl, key)
  local element = tbl[key]
  tbl[key] = nil
  return element
end

--- Reduces the given table returning a new table with only the given key values.
---@param tbl table
---@param keys any[]
---@return table<any, any>
function M.slice(tbl, keys)
  local result = {}

  for key, value in pairs(tbl) do
    if vim.tbl_contains(keys, key) then
      result[key] = value
    end
  end

  return result
end

function M.join_lists(tbl1, tbl2)
  local result = { M.unpack(tbl1) }
  for _, value in ipairs(tbl2) do
    table.insert(result, value)
  end

  return result
end

return M