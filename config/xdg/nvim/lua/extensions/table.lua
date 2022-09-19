--- Removes the given key from the table, returning its value.
---@param tbl table
---@param key any
---@return any
function table.removekey(tbl, key)
  local element = tbl[key]
  tbl[key] = nil
  return element
end

--- Reduces the given table returning a new table with only the given key values.
---@param tbl table
---@param keys any[]
---@return table<any, any>
function table.slice(tbl, keys)
  local result = {}

  for key, value in pairs(tbl) do
    if vim.tbl_contains(keys, key) then
      result[key] = value
    end
  end

  return result
end
