local stl = require('noice').api.statusline

local components = {
  {
    fn = stl.command.get,
    cond = stl.command.has,
  },
  {
    fn = stl.search.get,
    cond = stl.search.has,
  },
  {
    fn = stl.search.get,
    cond = stl.search.has,
  },
  {
    fn = stl.ruller.get,
    cond = stl.ruller.has,
  },
}

return {
  render = function()
    local value = ''

    for _, component in ipairs(components) do
      if component.cond() then
        value = value .. ' ' .. component.fn()
      end
    end

    return value
  end,
}