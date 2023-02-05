local default = function(nodes)
  local result = {}

  for _, node in ipairs(nodes) do
    local _, value = table.unpack(node)

    table.insert(result, value)
  end

  return table.concat(result, ' » ')
end

return {
  go = default,
  javascript = default,
  lua = default,
  ruby = require('config.hbar.components.treesitter-location.processors.ruby'),
}
