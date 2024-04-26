local tsutils = require('plugins.treesitter.utils')

local function get_parent_type(node, counter)
  local parent_node = tsutils.ancestor(node, counter)

  if parent_node ~= nil then
    return parent_node:type()
  end
end

vim.b.treesitter_statusline_options = {
  type_patterns = { 'class', 'module', 'method' },
  separator = '',
  transform_fn = function(_line, node)
    local type = node:type()
    local text = tsutils.next_children_text(node, { 'identifier', 'constant' }) or ''
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
