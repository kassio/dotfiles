local utils = require('../utils')
local log = hs.logger.new('GlobalShortcuts', 'debug')
local obj = {}
obj.__index = obj

obj.name = 'GlobalShortcuts'
obj.version = '0.2'
obj.author = 'kassioborges <kassioborgesm@gmail.com>'
obj.homepage = 'https://github.com/kassio/dotfiles'
obj.license = 'MIT - https://opensource.org/licenses/MIT'

-- noop event, useful to
-- - disable existing shortcuts
-- - when the action is not an event, after the action return a noop event
local noop = function()
  return true, {}
end

local offset = function(modifiers)
  if utils.tbl_contains(modifiers, 'cmd') then
    return 9999
  elseif utils.tbl_contains(modifiers, 'shift') then
    return 100
  elseif utils.tbl_contains(modifiers, 'alt') then
    return 50
  else
    return 10
  end
end

local selectMenuItem = function(app, path)
  local result = app:selectMenuItem(path)

  if result == nil then
    log.i(string.format('[ERROR][%s] app menu not found: %s',
      app:title(),
      hs.inspect(path)
    ))
  end

  return noop()
end

local counters = {}
setmetatable(counters, {
  __index = function(tbl, key)
    tbl[key] = 0
    return tbl[key]
  end
})

local double_cmd_q = function(app)
  if counters[app:title()] >= 1 then
    counters[app:title()] = 0
    app:kill()
  else
    hs.alert.show('Press cmd+q again to close '..app:title())
    counters[app:title()] = counters[app:title()] + 1

    -- reset counter after 2 seconds
    hs.timer.doAfter(2, function()
      if counters[app:title()] <= 1 then
        counters[app:title()] = 0
      end
    end)
  end

  return noop()
end

local app_handlers = {
  ['Safari'] = function(app, flags, char)
    if flags:contain({ 'cmd' }) and char == 'i' then
      return noop()
    elseif flags:containExactly({ 'cmd' }) and char == 'q' then
      return double_cmd_q(app)
    end
  end,

  ['Slack'] = function(app, flags, char)
    if flags:containExactly({ 'cmd' }) and char == 'q' then
      return double_cmd_q(app)
    end
  end,

  ['iTerm2'] = function(app, flags, char)
    if flags:containExactly({ 'cmd' }) and char == 'q' then
      return double_cmd_q(app)
    end
  end,

  ['Preview'] = function(app, flags, char)
    if flags:containExactly({ 'cmd', 'alt', 'ctrl' }) and char == 'i' then
      return selectMenuItem(app, { 'Tools', 'Adjust Size...' })
    elseif flags:containExactly({ 'cmd', 'shift' }) and char == 'e' then
      return selectMenuItem(app, { 'File', 'Export…' })
    end
  end
}

local fn_handlers = {
  h = function(modifiers)
    return true, { hs.eventtap.event.newKeyEvent(modifiers, 'left', true) }
  end,
  j = function(modifiers)
    return true, { hs.eventtap.event.newKeyEvent(modifiers, 'down', true) }
  end,
  k = function(modifiers)
    return true, { hs.eventtap.event.newKeyEvent(modifiers, 'up', true) }
  end,
  l = function(modifiers)
    return true, { hs.eventtap.event.newKeyEvent(modifiers, 'right', true) }
  end,
  y = function(modifiers)
    return true, { hs.eventtap.event.newScrollEvent({ offset(modifiers), 0 }, {}, 'line') }
  end,
  u = function(modifiers)
    return true, { hs.eventtap.event.newScrollEvent({ 0, -offset(modifiers) }, {}, 'line') }
  end,
  i = function(modifiers)
    return true, { hs.eventtap.event.newScrollEvent({ 0, offset(modifiers) }, {}, 'line') }
  end,
  o = function(modifiers)
    return true, { hs.eventtap.event.newScrollEvent({ -offset(modifiers), 0 }, {}, 'line') }
  end,
  [','] = function()
    local currentpos = hs.mouse.getAbsolutePosition()
    return true, { hs.eventtap.leftClick(currentpos) }
  end,
  ['.'] = function()
    local currentpos = hs.mouse.getAbsolutePosition()
    return true, { hs.eventtap.rightClick(currentpos) }
  end,
}

function obj:init()
  local function catcher(event)
    local flags = event:getFlags()
    local char = string.lower(event:getCharacters(true))
    local app = hs.application.frontmostApplication()
    local fn_handler = fn_handlers[char]
    local app_handler = app_handlers[app:title()]

    -- Global shortcuts to all applications
    if flags:containExactly({ 'cmd', 'alt', 'ctrl' }) and char == 'm' then
      return selectMenuItem(app, { 'Window', 'Merge All Windows' })
    elseif flags:containExactly({ 'cmd' }) and char == '/' then
      return selectMenuItem(app, { 'Help' })

      -- Global shortcuts fn-based
    elseif flags:contain({ 'fn' }) and fn_handler then
      local modifiers = utils.tbl_remove(utils.tbl_keys(flags), { 'fn' })
      return fn_handler(modifiers)

      -- App specific shortcuts
    elseif app_handler then
      local result = app_handler(app, flags, char)
      return result or true, { event }

      -- Fallbacks to run the given event
    else
      return true, { event }
    end
  end

  ft_tapper = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, catcher):start()
end

return obj
