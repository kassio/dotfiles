local function get_parent(node, counter)
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

local function get_parent_type(node, counter)
  local parent_node = get_parent(node, counter)

  if parent_node ~= nil then
    return parent_node:type()
  end
end

local function next_children_text(node, types)
  for child in node:iter_children() do
    if vim.tbl_contains(types, child:type()) then
      return vim.treesitter.get_node_text(child, 0)
    end
  end
end

vim.b.treesitter_statusline_options = {
  type_patterns = { 'class', 'module', 'method' },
  separator = '',
  transform_fn = function(_line, node)
    local type = node:type()
    local text = next_children_text(node, { 'identifier', 'constant' }) or ''
    local parent_type = get_parent_type(node, 2)

    if type == 'method' and parent_type == 'singleton_class' then
      text = '.' .. text
    elseif type == 'singleton_method' then
      text = '.' .. text
    elseif type == 'method' then
      text = '#' .. text
    elseif type == 'singleton_class' then
      text = '' -- this is required to avoid empty `::` with class << self
    else
      text = '::' .. text
    end

    return text
  end,
}
