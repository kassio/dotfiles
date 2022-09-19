--- Converts given string to CamelCase.
---@param str string
---@return string, integer
function string.camelcase(str)
  return str:gsub('_(.)', str.upper):gsub('^(.)', str.upper)
end

--- Trim spaces on both sides of the given string
---@param str string
---@return string, integer
function string.trim(str)
  return str:gsub('^%s*(.-)%s*$', '%1')
end
