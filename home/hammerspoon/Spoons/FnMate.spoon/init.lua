-- Original author: ashfinal <ashfinal@gmail.com>
-- Based on https://github.com/Hammerspoon/Spoons/raw/master/Spoons/FnMate.spoon.zip

local obj = {}
obj.__index = obj

obj.name = 'FnMate'
obj.version = '1.1'
obj.author = 'kassioborges <kassioborgesm@gmail.com>'
obj.homepage = 'https://github.com/kassio/dotfiles'
obj.license = 'MIT - https://opensource.org/licenses/MIT'

local H = {}

H.remove = function(t, list)
  assert(type(t) == 'table', string.format('Expected table, got %s', type(t)))
  assert(type(list) == 'table', string.format('Expected table, got %s', type(t)))

  local result = {}
  for _, v in pairs(t) do
    if not H.contains(list, v) then
      table.insert(result, v)
    end
  end

  return result
end

H.keys = function(t, except)
  assert(type(t) == 'table', string.format('Expected table, got %s', type(t)))

  local keys = {}
  for k, _ in pairs(t) do
    if except == nil or k ~= except then
      table.insert(keys, k)
    end
  end

  return keys
end

H.contains = function(tbl, given)
  local result = false

  for _, value in ipairs(tbl) do
    if value == given then
      result = true
      break
    end
  end

  return result
end

local moving = {
  config = {
    h = 'left',
    j = 'down',
    k = 'up',
    l = 'right',
    -- when opt is down
    ['˙'] = 'left',
    ['∆'] = 'down',
    ['˚'] = 'up',
    ['¬'] = 'right',
    -- when opt+shift is down
    ['Ó'] = 'left',
    ['Ô'] = 'down',
    [''] = 'up',
    ['Ò'] = 'right',
  },
}
moving.chars = H.keys(moving.config)

local scrolling = {
  config = { y = { 3, 0 }, o = { -3, 0 }, u = { 0, -3 }, i = { 0, 3 } },
}
scrolling.chars = H.keys(scrolling.config)

function obj:init()
  local function catcher(event)
    local flags = event:getFlags()
    local char = string.lower(event:getCharacters())

    -- move with modifiers
    if flags['fn'] and H.contains(moving.chars, char) then
      local modifiers = H.remove(H.keys(flags), { 'fn' })

      return true, {
        hs.eventtap.event.newKeyEvent(modifiers, moving.config[char], true),
      }

      -- scroll
    elseif flags['fn'] and H.contains(scrolling.chars, char) then
      return true, {
        hs.eventtap.event.newScrollEvent(scrolling.config[char], {}, 'line'),
      }

      -- click
    elseif flags['fn'] and char == ',' then
      local currentpos = hs.mouse.getAbsolutePosition()
      return true, { hs.eventtap.leftClick(currentpos) }
    elseif flags['fn'] and char == '.' then
      local currentpos = hs.mouse.getAbsolutePosition()
      return true, { hs.eventtap.rightClick(currentpos) }
    end
  end

  ft_tapper = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, catcher):start()
end

return obj
