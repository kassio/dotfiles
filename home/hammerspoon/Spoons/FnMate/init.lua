-- Original author: ashfinal <ashfinal@gmail.com>
-- Based on https://github.com/Hammerspoon/Spoons/raw/master/Spoons/FnMate.spoon.zip

local function init()
  local function catcher(event)
    local flags = event:getFlags()
    local chars = event:getCharacters()

    -- move
    if flags['fn'] and chars == "h" then
      return true, {hs.eventtap.event.newKeyEvent({}, "left", true)}
    elseif flags['fn'] and chars == "l" then
      return true, {hs.eventtap.event.newKeyEvent({}, "right", true)}
    elseif flags['fn'] and chars == "j" then
      return true, {hs.eventtap.event.newKeyEvent({}, "down", true)}
    elseif flags['fn'] and chars == "k" then
      return true, {hs.eventtap.event.newKeyEvent({}, "up", true)}

    -- select
    elseif flags['fn'] and chars == "H" then
      return true, {hs.eventtap.event.newKeyEvent({ 'shift' }, "left", true)}
    elseif flags['fn'] and chars == "L" then
      return true, {hs.eventtap.event.newKeyEvent({ 'shift' }, "right", true)}
    elseif flags['fn'] and chars == "J" then
      return true, {hs.eventtap.event.newKeyEvent({ 'shift' }, "down", true)}
    elseif flags['fn'] and chars == "K" then
      return true, {hs.eventtap.event.newKeyEvent({ 'shift' }, "up", true)}

    -- scroll
    elseif flags['fn'] and chars == "y" then
      return true, {hs.eventtap.event.newScrollEvent({3, 0}, {}, "line")}
    elseif flags['fn'] and chars == "o" then
      return true, {hs.eventtap.event.newScrollEvent({-3, 0}, {}, "line")}
    elseif flags['fn'] and chars == "u" then
      return true, {hs.eventtap.event.newScrollEvent({0, -3}, {}, "line")}
    elseif flags['fn'] and chars == "i" then
      return true, {hs.eventtap.event.newScrollEvent({0, 3}, {}, "line")}

    -- click
    elseif flags['fn'] and chars == "," then
      local currentpos = hs.mouse.getAbsolutePosition()
      return true, {hs.eventtap.leftClick(currentpos)}
    elseif flags['fn'] and chars == "." then
      local currentpos = hs.mouse.getAbsolutePosition()
      return true, {hs.eventtap.rightClick(currentpos)}
    end
  end

  hs.eventtap.new({hs.eventtap.event.types.keyDown}, catcher):start()
end

init()
