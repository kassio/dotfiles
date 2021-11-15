local utils = hs.my.utils
local logger = hs.logger.new('GlobalShortcuts', 'debug')
local function script_path()
  local str = debug.getinfo(2, 'S').source:sub(2)
  return str:match('(.*/)')
end

local obj = {}
obj.__index = obj

obj.name = 'GlobalShortcuts'
obj.version = '0.2'
obj.author = 'kassioborges <kassioborgesm@gmail.com>'
obj.homepage = 'https://github.com/kassio/dotfiles'
obj.license = 'MIT - https://opensource.org/licenses/MIT'
obj.handlers_path = script_path() .. 'handlers'
package.path = package.path .. ';' .. obj.handlers_path .. '/?.lua'

utils.logger = logger

local counters = {}
setmetatable(counters, {
  __index = function(tbl, key)
    tbl[key] = 0
    return tbl[key]
  end,
})

utils.counters = counters

-- noop event, useful to
-- disable existing shortcuts
-- when the action is not an event, after the action return a noop event
utils.noop = function()
  return true, {}
end

utils.select_menu_item = function(app, path)
  local result = app:selectMenuItem(path)

  if result == nil then
    logger.i(string.format('[ERROR][%s] app menu not found: %s', app:title(), hs.inspect(path)))
  end

  return utils.noop()
end

local load_handlers = function()
  local list, handlers_list = {}, io.popen('ls -1 "' .. obj.handlers_path .. '"')

  for filename in handlers_list:lines() do
    local handler_name = string.gsub(filename, '%.lua', '')

    table.insert(list, require(handler_name))
  end

  handlers_list:close()

  return list
end

function obj:init()
  local handlers = load_handlers()

  local function catcher(event)
    for _, handler in ipairs(handlers) do
      local retap, new_event = handler.handle(event, utils)

      if retap then
        return retap, new_event
      end
    end

    return true, { event }
  end

  ft_tapper = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, catcher):start()
end

return obj
