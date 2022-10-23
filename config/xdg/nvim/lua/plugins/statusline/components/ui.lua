local ok, noice = pcall(require, 'noice')
if not ok then
  return {
    render = function()
      return ''
    end,
  }
end

local stl = noice.api.statusline

local components = {
  {
    fn = stl.search.get,
    cond = stl.search.has,
  },
  {
    fn = stl.ruler.get,
    cond = stl.ruler.has,
  },
  {
    fn = stl.command.get,
    cond = stl.command.has,
  },
}

return {
  render = function()
    local value = ''

    for _, component in ipairs(components) do
      if component.cond() then
        value = string.format('%s %s', value, component.fn())
      end
    end

    return string.format(' %s ', value)
  end,
}
