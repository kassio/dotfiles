local function second_parent_type(node, counter)
  counter = counter or 2
  if counter == 0 then
    return node ~= nil and node:type() or nil
  end

  node = node:parent()
  if node == nil then
    return
  end

  return second_parent_type(node, counter - 1)
end

vim.b.treesitter_statusline_options = {
  type_patterns = { 'class', 'module', 'method' },
  separator = '',
  transform_fn = function(value, node)
    -- methods
    value = string.gsub(value, '%([^)]*%)', '') -- prefix singleton method with .
    value = string.gsub(value, '%s*def%s+(%w+)%.(%w+)', '.%2') -- prefix singleton method with .

    if second_parent_type(node) == 'singleton_class' then
      value = string.gsub(value, '%s*def%s*', '.')
    else
      value = string.gsub(value, '%s*def%s*', '#')
    end

    -- class
    value = string.gsub(value, '%s*class%s+<<.*', '') -- prefix constants ::
    value = string.gsub(value, '%s*class%s*', '::') -- prefix constants ::
    value = string.gsub(value, '%s*<.*', '') -- remove inheritance

    -- module
    value = string.gsub(value, '%s*module%s*', '::') -- prefix constants ::

    return value
  end,
}
