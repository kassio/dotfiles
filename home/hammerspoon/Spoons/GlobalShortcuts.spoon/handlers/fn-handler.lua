local scroll_offset = function(modifiers, utils)
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
  y = function(modifiers, utils)
    return true, { hs.eventtap.event.newScrollEvent({ scroll_offset(modifiers, utils), 0 }, {}, 'line') }
  end,
  u = function(modifiers, utils)
    return true, { hs.eventtap.event.newScrollEvent({ 0, -scroll_offset(modifiers, utils) }, {}, 'line') }
  end,
  i = function(modifiers, utils)
    return true, { hs.eventtap.event.newScrollEvent({ 0, scroll_offset(modifiers, utils) }, {}, 'line') }
  end,
  o = function(modifiers, utils)
    return true, { hs.eventtap.event.newScrollEvent({ -scroll_offset(modifiers, utils), 0 }, {}, 'line') }
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

return {
  name = 'Fn Handler',
  handle = function(event, utils)
    local flags = event:getFlags()
    local char = string.lower(event:getCharacters(true))

    if flags:contain({ 'fn' }) then
      local modifiers = utils.tbl_remove(utils.tbl_keys(flags), { 'fn' })
      local handler = handlers[char]

      if handler then
        local a, b = handler(modifiers, utils)
        return a, b
      end
    end
  end,
}
