local M = {}

--- Converts given string to CamelCase.
---@param str string
---@return string, integer
function M.camelcase(str)
  return str:gsub('_(.)', str.upper):gsub('^(.)', str.upper)
end

--- Converts given string to underscore.
---@param str string
---@return string, integer
function M.snakecase(str)
  return str:gsub('(%l?)(%u)', function(l, u)
    if l == '' then
      return u:lower()
    else
      return l .. '_' .. u:lower()
    end
  end)
end

--- Trim spaces on both sides of the given string
---@param str string
---@return string, integer
function M.trim(str)
  return str:gsub('^%s*(.-)%s*$', '%1')
end

return M
