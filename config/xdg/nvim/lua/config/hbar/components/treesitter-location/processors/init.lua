local default = function(nodes)
  local text = ''

  for _, node in ipairs(nodes) do
    local _, value = table.unpack(node)

    text = text .. ' » ' .. value
  end

  return text
end

return {
  go = default,
  javascript = default,
  lua = default,
  ruby = require('config.hbar.components.treesitter-location.processors.ruby'),
}
