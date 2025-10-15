local M = {}

if not table.unpack then
  M.unpack = unpack
end

if not M.pack then
  function M.pack(...)
    return { ... }
  end
end

function M.keys_except(tbl, ...)
  local except = {...}
  local result = {}

  for key, _ in pairs(tbl) do
    if not vim.tbl_contains(except, key) then
      table.insert(result, key)
    end
  end

  return result
end

---Removes the given key from the table, returning its value.
---@param tbl table<any>
---@param key any
---@return any
function M.removekey(tbl, key)
  local element = tbl[key]
  tbl[key] = nil
  return element
end

---Reduces the given table returning a new table with only the given key values.
---@param tbl table<any>
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

---Compacts the given list-like table, removing empty/0/false/nil values
---@param tbl table<any>
---@return table<any>
function M.compact_list(tbl)
  return vim.tbl_filter(function(element)
    if require('utils').is_present(element) then
      return true
    else
      return false
    end
  end, tbl)
end

---Returns the key associated with the given value
---@param tbl table<any>
---@param value any
---@return any
function M.key_for(tbl, value)
  for k, v in pairs(tbl) do
    if v == value then
      return k
    end
  end
end

---Returns a new table with all the elements from the given tables
---@param tbl1 table<any>
---@param ... table<any> {...}
---@return table<any>
function M.join(tbl1, ...)
  local result = vim.deepcopy(tbl1)
  for _, tbl in ipairs({ ... }) do
    for _, value in ipairs(tbl) do
      table.insert(result, value)
    end
  end

  return result
end

return M
