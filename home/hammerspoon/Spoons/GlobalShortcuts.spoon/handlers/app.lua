local double_cmd_q = function(app, utils)
  if utils.counters[app:title()] >= 1 then
    utils.counters[app:title()] = 0
    app:kill()
  else
    hs.alert.show('Press cmd+q again to close ' .. app:title())
    utils.counters[app:title()] = utils.counters[app:title()] + 1

    -- reset counter after 2 seconds
    hs.timer.doAfter(2, function()
      if utils.counters[app:title()] <= 1 then
        utils.counters[app:title()] = 0
      end
    end)
  end

  return utils.noop()
end

local handlers = {
  ['Safari'] = function(app, flags, char, utils)
    if flags:contain({ 'cmd' }) and char == 'i' then
      return utils.noop()
    elseif flags:containExactly({ 'cmd' }) and char == 'q' then
      return double_cmd_q(app, utils)
    end
  end,

  ['Slack'] = function(app, flags, char, utils)
    if flags:containExactly({ 'cmd' }) and char == 'q' then
      return double_cmd_q(app, utils)
    end
  end,

  ['iTerm2'] = function(app, flags, char, utils)
    if flags:containExactly({ 'cmd' }) and char == 'q' then
      return double_cmd_q(app, utils)
    end
  end,

  ['Preview'] = function(app, flags, char, utils)
    if flags:containExactly({ 'cmd', 'alt', 'ctrl' }) and char == 'i' then
      return utils.select_menu_item(app, { 'Tools', 'Adjust Size...' })
    elseif flags:containExactly({ 'cmd', 'shift' }) and char == 'e' then
      return utils.select_menu_item(app, { 'File', 'Export…' })
    end
  end,
}

return {
  handle = function(event, utils)
    local flags = event:getFlags()
    local char = string.lower(event:getCharacters(true))
    local app = hs.application.frontmostApplication()
    local handler = handlers[app:title()]

    if handler then
      return handler(app, flags, char, utils)

      -- return result or true, { event }
    end
  end,
}
