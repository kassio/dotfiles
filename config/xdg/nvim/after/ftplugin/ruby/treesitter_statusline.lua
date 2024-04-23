local function tsparent(node, counter)
  counter = counter or 1
  repeat
    if node == nil then
      return
    end

    node = node:parent()
    counter = counter - 1
  until counter < 1

  return node
end

vim.b.treesitter_statusline_options = {
  type_patterns = { 'class', 'module', 'method' },
  separator = '',
  transform_fn = function(_line, node)
    local value
    for child in node:iter_children() do
      local type = child:type()
      if type == 'identifier' or type == 'constant' then
        value = vim.treesitter.get_node_text(child, 0)
      end
    end

    local type = node:type()
    local second_parent = tsparent(node, 2)
    local second_parent_type
    if second_parent ~= nil then
      second_parent_type = second_parent:type()
    end

    if type == 'method' and second_parent_type == 'singleton_class' then
      value = '.' .. value
    elseif type == 'singleton_method' then
      value = '.' .. value
    elseif type == 'method' then
      value = '#' .. value
    elseif type == 'singleton_class' then
      value = '' -- this is required to avoid empty `::` with class << self
    else
      value = '::' .. value
    end

    return value
  end,
}
