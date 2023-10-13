local M = {}

if not table.unpack then
  M.unpack = unpack
end

if not M.pack then
  function M.pack(...)
    return { ... }
  end
end

---Removes the given key from the table, returning its value.
---@param tbl table
---@param key any
---@return any
function M.removekey(tbl, key)
  local element = tbl[key]
  tbl[key] = nil
  return element
end

---Reduces the given table returning a new table with only the given key values.
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

---Joins two list-like tables in a new list-like table
---@param tbl1 table
---@param tbl2 table
---@return table<any>
function M.join_lists(tbl1, tbl2)
  local result = { M.unpack(tbl1) }
  for _, value in ipairs(tbl2) do
    table.insert(result, value)
  end

  return result
end

---Compacts the given list-like table, removing empty/0/false/nil values
---@param tbl table
---@return table<any>
function M.compact_list(tbl)
  return vim.tbl_filter(function(element)
    local t = type(element)
    if vim.tbl_contains({ 'string', 'table' }, t) then
      return #element > 0
    elseif t == 'number' then
      return element ~= 0
    elseif t == 'nil' then
      return false
    else
      return element
    end
  end, tbl)
end

---Returns the key associated with the given value
---@param tbl table
---@param value any
---@return any
function M.key_for(tbl, value)
  for k, v in pairs(tbl) do
    if v == value then
      return k
    end
  end
end

return M
