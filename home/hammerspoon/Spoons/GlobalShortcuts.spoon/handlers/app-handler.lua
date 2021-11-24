local handlers = {
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

    utils.logger.i(hs.inspect({
      locked = utils.locked
    }))

    if not utils.locked and handler then
      return handler(app, flags, char, utils)
    end
  end,
}
