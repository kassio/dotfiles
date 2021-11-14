local utils = require('../utils')
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
obj.spoonPath = script_path()

package.path = package.path .. ';' .. obj.spoonPath .. 'handlers/?.lua'

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

function obj:init()
  local handlers_names = {
    'global',
    'fn',
    'app',
  }

  local load_handler = function(name)
    local path = package.searchpath(name, package.path)
    return loadfile(path)()
  end

  local load_handlers = function()
    return hs.fnutils.map(handlers_names, function(handler_name)
      local handler = load_handler(handler_name)
      handler.name = handler_name
      return handler
    end)
  end

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
