local tsutils = require('plugins.treesitter.utils')

local function get_parent_type(node, counter)
  local parent_node = tsutils.ancestor(node, counter)

  if parent_node ~= nil then
    return parent_node:type()
  end
end

return {
  type_patterns = { 'comment', 'assignment', 'class', 'module', 'method' },
  separator = '',
  transform_fn = function(node)
    local type = node:type()

    local text
    if
      (
        vim.tbl_contains({ 'module', 'class', 'singleton_class' }, get_parent_type(node, 2))
        or get_parent_type(node, 1) == 'program'
      ) and vim.tbl_contains({ 'assignment' }, type)
    then
      -- constant assignment
      text = tsutils.next_children_text(node, '::', { 'constant' })
    elseif vim.tbl_contains({ 'class', 'module' }, type) then
      -- constant nesting
      text = tsutils.next_children_text(node, '::', { 'constant' })
    elseif vim.tbl_contains({ 'method', 'singleton_method' }, type) then
      -- singleton method
      text = tsutils.next_children_text(node, '::', { 'identifier' })
    end

    if not text then
      -- Remove connection symbols from non-constant assignment and singleton_class
      return ''
    elseif get_parent_type(node, 1) == 'program' then
      -- Remove first `::`
      return text
    elseif type == 'method' and get_parent_type(node, 2) == 'singleton_class' then
      -- When inside a class << self block
      return '.' .. text
    elseif type == 'singleton_method' then
      return '.' .. text
    elseif type == 'method' then
      return '#' .. text
    else
      return '::' .. text
    end
  end,
}
