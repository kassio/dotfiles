return function(nodes)
  local text = ''
  local count = 0

  for _, node in ipairs(nodes) do
    local type, value = table.unpack(node)
    if type == 'constant' and count == 0 then
      text = value
    elseif type == 'constant' and count ~= 0 then
      text = text .. '::' .. value
    elseif type == 'class_method' then
      text = text .. '.' .. value
    elseif type == 'instance_method' then
      text = text .. '#' .. value
    end

    count = count + 1
  end

  return text
end
