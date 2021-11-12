-- Original author: ashfinal <ashfinal@gmail.com>
-- Based on https://github.com/Hammerspoon/Spoons/raw/master/Spoons/FnMate.spoon.zip

local utils = require('../utils')
local obj = {}
obj.__index = obj

obj.name = 'FnMate'
obj.version = '1.1'
obj.author = 'kassioborges <kassioborgesm@gmail.com>'
obj.homepage = 'https://github.com/kassio/dotfiles'
obj.license = 'MIT - https://opensource.org/licenses/MIT'

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

local handlers = {
  [4] = function(modifiers) -- 'h'
    return true, { hs.eventtap.event.newKeyEvent(modifiers, 'left', true) }
  end,
  [38] = function(modifiers) -- 'j'
    return true, { hs.eventtap.event.newKeyEvent(modifiers, 'down', true) }
  end,
  [40] = function(modifiers) -- 'k'
    return true, { hs.eventtap.event.newKeyEvent(modifiers, 'up', true) }
  end,
  [37] = function(modifiers) -- 'l'
    return true, { hs.eventtap.event.newKeyEvent(modifiers, 'right', true) }
  end,
  [16] = function(modifiers) -- 'y'
    return true, { hs.eventtap.event.newScrollEvent({ offset(modifiers), 0 }, {}, 'line') }
  end,
  [32] = function(modifiers) -- 'u'
    return true, { hs.eventtap.event.newScrollEvent({ 0, -offset(modifiers) }, {}, 'line') }
  end,
  [34] = function(modifiers) -- 'i'
    return true, { hs.eventtap.event.newScrollEvent({ 0, offset(modifiers) }, {}, 'line') }
  end,
  [31] = function(modifiers) -- 'o'
    return true, { hs.eventtap.event.newScrollEvent({ -offset(modifiers), 0 }, {}, 'line') }
  end,
  [43] = function() -- ','
    local currentpos = hs.mouse.getAbsolutePosition()
    return true, { hs.eventtap.leftClick(currentpos) }
  end,
  [47] = function() -- '.'
    local currentpos = hs.mouse.getAbsolutePosition()
    return true, { hs.eventtap.rightClick(currentpos) }
  end,
}

function obj:init()
  local function catcher(event)
    local flags = event:getFlags()
    local key = event:getKeyCode()
    local handler = handlers[key]

    if flags['fn'] and handler then
      local modifiers = utils.tbl_remove(utils.tbl_keys(flags), { 'fn' })

      return handler(modifiers)
    end
  end

  ft_tapper = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, catcher):start()
end

return obj
