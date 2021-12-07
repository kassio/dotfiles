return {
  name = 'Global Handler',
  handle = function(event, utils)
    local flags = event:getFlags()
    local char = string.lower(event:getCharacters(true))
    local app = hs.application.frontmostApplication()

    if flags:containExactly({ 'cmd', 'alt', 'ctrl' }) and char == 'm' then
      utils.select_menu_item(app, { 'Window', 'Merge All Windows' })
    end
  end,
}
